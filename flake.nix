{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.49.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/v0.49.0-fix";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprland.follows = "hyprland";
      };
    };

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      utils = import ./lib/utils.nix { lib = nixpkgs.lib; };
      system = "x86_64-linux";

      user = rec {
        username = "muhifauzan";
        homedir = "/home/${username}";
        name = "Muhammad Hilmy Fauzan";
      };

      defaultMachine = utils.mkDefaults { inherit system user inputs; };

      machines = {
        workstation = utils.mkMachine defaultMachine {
          hostname = "panthera";
          aliases = [ "pc" ];
        };

        laptop = utils.mkMachine defaultMachine {
          hostname = "acinonyx";
        };

        server = utils.mkMachine defaultMachine {
          homeManager = false;
        };
      };

    in
    {
      debug = utils.showConfigurations machines;
      validate = utils.validateMachines (
        nixpkgs.lib.mapAttrs (_: resolved: resolved.machine) (utils.autoResolveConfigurations machines)
      );
      nixosConfigurations = utils.buildConfigurations machines;
    };
}
