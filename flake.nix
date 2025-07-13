{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      nixpkgs,
      treefmt-nix,
      quadlet-nix,
      ...
    }@inputs:
    let
      utils = import ./lib/utils.nix { lib = nixpkgs.lib; };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      user = rec {
        username = "muhifauzan";
        homedir = "/home/${username}";
        name = "Muhammad Hilmy Fauzan";
      };

      mkMachine = utils.mkMachineDefaults { inherit inputs system user; };

      machines = {
        workstation = mkMachine {
          hostname = "panthera";
          aliases = [ "pc" ];
        };

        laptop = mkMachine {
          hostname = "acinonyx";
        };

        server = mkMachine {
          homeManager = false;
        };
      };

      extraModules = [ quadlet-nix.nixosModules.quadlet ];
      extraHomeManagerModules = [ quadlet-nix.homeManagerModules.quadlet ];
    in
    {
      nixosConfigurations = utils.buildConfigurations machines extraModules extraHomeManagerModules;

      formatter.${system} = treefmt-nix.lib.mkWrapper pkgs {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        settings.global.includes = [ "*.nix" ];
        settings.global.excludes = [ ".knowledge/*" ];
      };

      debug = { inherit machines utils; };
    };
}
