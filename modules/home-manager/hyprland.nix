{ inputs, pkgs, ... }:

{
  imports = [
    ./hyprland-config.nix
    ./hyprland-plugin-config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
      hyprexpo
    ];
  };

  services = {
    hyprpolkitagent.enable = true;
    mako.enable = true;
  };

  home.packages = with pkgs; [
    kdePackages.dolphin
    kitty
    wofi
  ];
}

