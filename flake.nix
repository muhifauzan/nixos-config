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

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
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
      system = "x86_64-linux";

      homeManagerConfig = {
        home-manager = {
          backupFileExtension = "bak";
          useGlobalPkgs = true;
          useUserPackages = true;

          extraSpecialArgs = {
            inherit inputs;
            inherit system;
          };
        };
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./hosts/default/configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
      };
    };
}
