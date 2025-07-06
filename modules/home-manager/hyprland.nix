{
  pkgs,
  machine,
  inputs,
  ...
}:

let
  inherit (machine) system;
  hyprlandPackages = inputs.hyprland.packages.${system};
  hyprlandPlugins = inputs.hyprland-plugins.packages.${system};
in
{
  imports = [
    ./hyprland-config.nix
    ./hyprland-plugin.nix
  ];

  config = {
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kwallet
      rofi-wayland
    ];

    programs = {
      hyprpanel.enable = true;

      kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;

        font = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      # Set to null because it's being installed via NixOS module
      package = null;

      # Use the one from flake
      portalPackage = hyprlandPackages.xdg-desktop-portal-hyprland;

      plugins = with hyprlandPlugins; [
        hyprbars
        hyprexpo
      ];
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

      config.hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
      };
    };

    services = {
      hyprpolkitagent.enable = true;

      # NOTE: switch to true if not using hyprpanel
      mako.enable = false;
    };
  };
}
