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
      system = "x86_64-linux";
      workstation = "panthera";
      laptop = "acinonyx";

      user = rec {
        username = "muhifauzan";
        homedir = "/home/${username}";
        name = "Muhammad Hilmy Fauzan";
      };

      buildConfiguration =
        {
          system,
          hostname,
          user,
          home-manager,
          inputs,
          nixosConfig,
          homeManagerConfig,
        }:

        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              system
              hostname
              user
              inputs
              ;
          };

          modules = [
            nixosConfig
            home-manager.nixosModules.home-manager

            {
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];

              home-manager = {
                extraSpecialArgs = {
                  inherit
                    system
                    hostname
                    user
                    inputs
                    ;
                };

                backupFileExtension = "bak";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user.username} = homeManagerConfig;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        ${workstation} = buildConfiguration {
          inherit
            system
            user
            home-manager
            inputs
            ;

          hostname = laptop;
          nixosConfig = ./hosts/default/configuration.nix;
          homeManagerConfig = ./hosts/default/home.nix;
        };

        ${laptop} = buildConfiguration {
          inherit
            system
            user
            home-manager
            inputs
            ;

          hostname = laptop;
          nixosConfig = ./hosts/default/configuration.nix;
          homeManagerConfig = ./hosts/default/home.nix;
        };
      };
    };
}
