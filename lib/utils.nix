{ lib, ... }:

let
  defaultMachine = {
    # Required
    system = null;
    user = null;
    inputs = null;

    # Auto-resolved
    hostname = null;
    configDir = null;
    nixosConfig = null;
    homeManager = null;
    homeManagerConfig = null;

    # Optional
    aliases = [ ];
  };

  mkMachineDefaults = defaults: overrides: defaultMachine // defaults // overrides;

  validateMachines =
    machines:
    let
      collectNames =
        name: machine:
        let
          hostname = machine.hostname;
          aliases = machine.aliases;

          mkRecord = recordName: source: {
            inherit source hostname;

            name = recordName;
            machine = name;
          };

        in
        [ (mkRecord name "primary") ]
        ++ lib.optional (hostname != null && hostname != name) (mkRecord hostname "hostname")
        ++ lib.map (alias: mkRecord alias "alias") aliases;

      allNameSources = lib.flatten (lib.mapAttrsToList collectNames machines);
      nameGroups = lib.groupBy (item: item.name) allNameSources;
      conflicts = lib.filterAttrs (name: items: lib.length items > 1) nameGroups;

      formatConflict =
        name: items:
        let
          sources = lib.map (
            item: "${item.machine} (hostname: ${item.hostname}, source: ${item.source})"
          ) items;
        in
        "Name '${name}' conflicts between: ${lib.concatStringsSep ", " sources}";

      conflictMessages = lib.mapAttrsToList formatConflict conflicts;
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

          home-manager = {
            backupFileExtension = "bak";
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${machine.user.username} = homeManagerConfig;
            extraSpecialArgs = { inherit machine inputs; };
          };
        })
      ];
    };

  collectAllNames =
    machineConfigs:
    lib.foldlAttrs
      (acc: name: machine: {
        names = acc.names ++ [ name ];
        hostnames = acc.hostnames ++ [ machine.hostname ];
        aliases = acc.aliases ++ machine.aliases;
        allAliases = acc.allAliases ++ [ machine.hostname ] ++ machine.aliases;
      })
      {
        names = [ ];
        hostnames = [ ];
        aliases = [ ];
        allAliases = [ ];
      }
      machineConfigs;

  resolveMachineConfigs =
    machines: lib.mapAttrs (_: resolved: resolved.machine) (autoResolveConfigurations machines);

  buildConfigurations =
    machines:
    let
      machineConfigs = resolveMachineConfigs machines;

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

      nameCollections = collectAllNames machineConfigs;
      aliases = nameCollections.allAliases;

      findConfigForAlias =
        alias:
        let
          matchName = lib.findFirst (
            name: machineConfigs.${name}.hostname == alias || lib.elem alias machineConfigs.${name}.aliases
          ) null (lib.attrNames machineConfigs);
        in
        configs.${matchName};

      aliasConfigs = lib.genAttrs aliases findConfigForAlias;

    in
    configs // aliasConfigs;

  mkResolver =
    key: resolverFn:
    { machine, autoResolve }:
    let
      resolved = resolverFn machine;
    in
    {
      machine = machine // {
        ${key} = resolved.value;
      };
      autoResolve = autoResolve // {
        ${key} = resolved.isAuto;
      };
    };

  autoResolveConfigurations = machines: lib.mapAttrs autoResolveMachine machines;

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

  autoResolveConfigDir = mkResolver "configDir" (
    machine:
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
      }
  );

  autoResolveNixosConfig = mkResolver "nixosConfig" (
    machine:
    if machine.nixosConfig != null then
      {
        value = machine.nixosConfig;
        isAuto = false;
      }
    else
      {
        value = machine.configDir + "/configuration.nix";
        isAuto = true;
      }
  );

  autoResolveHomeManagerConfig = mkResolver "homeManagerConfig" (
    machine:
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
      }
  );

  showConfigurations =
    machines:
    let
      resolvedConfigs = autoResolveConfigurations machines;
      machineConfigs = resolveMachineConfigs machines;

      nameCollections = collectAllNames machineConfigs;
      names = nameCollections.names;
      hostnames = nameCollections.hostnames;
      aliases = nameCollections.aliases;

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

      totalNames = lib.length (names ++ nameCollections.allAliases);
    };

  withNormalization = f: machines: f (lib.mapAttrs (_: machine: defaultMachine // machine) machines);

  test = {
    validateMachines = withNormalization validateMachines;
    showConfigurations = withNormalization showConfigurations;
  };

in
{
  inherit
    buildConfigurations
    mkMachineDefaults
    test
    ;
}
