{ lib }:

let
  mkDefaults =
    {
      system,
      user,
      inputs,
      hostname ? null,
      configDir ? null,
      nixosConfig ? null,
      homeManager ? null,
      homeManagerConfig ? null,
      aliases ? [ ],
    }:
    {
      inherit
        system
        hostname
        user
        configDir
        nixosConfig
        homeManager
        homeManagerConfig
        inputs
        aliases
        ;
    };

  mkMachine = defaults: overrides: defaults // overrides;

  validateMachines =
    machines:
    let
      primaryNames = lib.attrNames machines;

      collectNamesWithSource = lib.foldl' (
        acc: name:
        let
          machine = machines.${name};
          hostname = machine.hostname;
          aliases = machine.aliases;
        in
        lib.concatLists [
          acc
          [
            {
              name = name;
              source = "primary";
              machine = name;
              hostname = hostname;
            }
          ]
          (lib.optional (hostname != name) {
            name = hostname;
            source = "hostname";
            machine = name;
            hostname = hostname;
          })
          (lib.map (alias: {
            name = alias;
            source = "alias";
            machine = name;
            hostname = hostname;
          }) aliases)
        ]
      ) [ ] primaryNames;

      nameGroups = lib.groupBy (item: item.name) collectNamesWithSource;
      conflicts = lib.filterAttrs (name: items: lib.length items > 1) nameGroups;

      conflictMessages = lib.mapAttrsToList (
        name: items:
        let
          sources = lib.map (
            item: "${item.machine} (hostname: ${item.hostname}, source: ${item.source})"
          ) items;
        in
        "Name '${name}' conflicts between: ${lib.concatStringsSep ", " sources}"
      ) conflicts;

    in
    if conflicts == { } then
      true
    else
      throw "Machine configuration conflicts:\n${lib.concatStringsSep "\n" conflictMessages}";

  buildConfiguration =
    {
      system,
      hostname,
      user,
      nixosConfig,
      inputs,
      homeManagerConfig ? null,
    }:
    let
      machine = { inherit system hostname user; };
    in
    lib.nixosSystem {
      specialArgs = { inherit machine inputs; };

      modules = [
        nixosConfig

        (lib.optionalAttrs (homeManagerConfig != null) {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
        })

        {
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          home-manager = lib.mkIf (homeManagerConfig != null) {
            backupFileExtension = "bak";
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${machine.user.username} = homeManagerConfig;
            extraSpecialArgs = { inherit machine inputs; };
          };
        }
      ];
    };

  buildConfigurations =
    machines:
    let
      machineConfigs = lib.mapAttrs (_: resolved: resolved.machine) (autoResolveConfigurations machines);

      configs = lib.mapAttrs (
        name: machine:
        buildConfiguration {
          system = machine.system;
          hostname = machine.hostname;
          user = machine.user;
          nixosConfig = machine.nixosConfig;
          homeManagerConfig = machine.homeManagerConfig;
          inputs = machine.inputs;
        }
      ) machineConfigs;

      hostnameAliases = lib.mapAttrs' (
        name: machine: lib.nameValuePair machine.hostname configs.${name}
      ) machineConfigs;

      customAliases = lib.foldlAttrs (
        acc: name: machine:
        let
          aliases = lib.listToAttrs (
            lib.map (alias: lib.nameValuePair alias configs.${name}) machine.aliases
          );
        in
        acc // aliases
      ) { } machineConfigs;

    in
    configs // hostnameAliases // customAliases;

  autoResolveConfigurations =
    machines: lib.mapAttrs (name: machine: autoResolveMachine name machine) machines;

  autoResolveMachine =
    name: machine:
    lib.pipe (autoResolveHostname name machine) [
      autoResolveConfigDir
      autoResolveNixosConfig
      autoResolveHomeManagerConfig
    ];

  autoResolveHostname =
    name: machine:
    let
      resolved =
        if machine.hostname != null then
          {
            value = machine.hostname;
            isAuto = false;
          }
        else
          {
            value = name;
            isAuto = true;
          };
    in
    {
      machine = machine // {
        hostname = resolved.value;
      };
      autoResolve = {
        hostname = resolved.isAuto;
      };
    };

  autoResolveConfigDir =
    { machine, autoResolve }:
    let
      resolved =
        if lib.isPath machine.configDir then
          {
            value = machine.configDir;
            isAuto = false;
          }
        else if lib.isString machine.configDir then
          {
            value = ../hosts/${machine.configDir};
            isAuto = true;
          }
        else if lib.pathExists (../hosts + "/${machine.hostname}") then
          {
            value = ../hosts/${machine.hostname};
            isAuto = true;
          }
        else
          {
            value = ../hosts/default;
            isAuto = true;
          };
    in
    {
      machine = machine // {
        configDir = resolved.value;
      };
      autoResolve = autoResolve // {
        configDir = resolved.isAuto;
      };
    };

  autoResolveNixosConfig =
    { machine, autoResolve }:
    let
      resolved =
        if machine.nixosConfig != null then
          {
            value = machine.nixosConfig;
            isAuto = false;
          }
        else
          {
            value = machine.configDir + "/configuration.nix";
            isAuto = true;
          };
    in
    {
      machine = machine // {
        nixosConfig = resolved.value;
      };
      autoResolve = autoResolve // {
        nixosConfig = resolved.isAuto;
      };
    };

  autoResolveHomeManagerConfig =
    { machine, autoResolve }:
    let
      resolved =
        if machine.homeManager == false then
          {
            value = null;
            isAuto = false;
          }
        else if machine.homeManagerConfig != null then
          {
            value = machine.homeManagerConfig;
            isAuto = false;
          }
        else if machine.homeManager == true || lib.pathExists (machine.configDir + "/home.nix") then
          {
            value = machine.configDir + "/home.nix";
            isAuto = true;
          }
        else
          {
            value = null;
            isAuto = false;
          };
    in
    {
      machine = machine // {
        homeManagerConfig = resolved.value;
      };
      autoResolve = autoResolve // {
        homeManagerConfig = resolved.isAuto;
      };
    };

  showConfigurations =
    machines:
    let
      resolvedConfigs = autoResolveConfigurations machines;
      machineConfigs = lib.mapAttrs (key: resolved: resolved.machine) resolvedConfigs;

      names = lib.attrNames machineConfigs;
      hostnames = lib.mapAttrsToList (_: machine: machine.hostname) machineConfigs;
      aliases = lib.concatLists (lib.mapAttrsToList (_: machine: machine.aliases) machineConfigs);

      pathInfo = lib.mapAttrs (
        name: resolved:
        let
          machine = {
            hostname = resolved.machine.hostname;
            nixosConfig = resolved.machine.nixosConfig;
            homeManagerConfig = resolved.machine.homeManagerConfig;
            configDir = resolved.machine.configDir;
          };
          autoResolve = resolved.autoResolve;
        in
        {
          inherit machine autoResolve;
        }
      ) resolvedConfigs;

    in
    {
      inherit
        names
        hostnames
        aliases
        pathInfo
        ;

      totalNames = lib.length (
        lib.concatLists [
          names
          hostnames
          aliases
        ]
      );
    };
in
{
  inherit
    buildConfigurations
    mkDefaults
    mkMachine
    showConfigurations
    validateMachines
    autoResolveConfigurations
    ;
}
