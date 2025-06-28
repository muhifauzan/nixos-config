{ pkgs, ... }:

{
  imports = [
    ./hyprland-config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  services = {
    hyprpolkitagent.enable = true;
    mako.enable = true;
  };

  home.packages = with pkgs; [
    kitty
  ];
}

