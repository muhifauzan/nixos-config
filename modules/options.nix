{ config, lib, ... }:

let
  inherit (lib) mkDefault mkEnableOption;
  cfg = config.modules;
in
{
  imports = [
    ./options
  ];

  options = {
    modules = {
      essential-packages.enable = mkEnableOption "essential packages";
      system-packages.enable = mkEnableOption "system utility packages";
      network-packages.enable = mkEnableOption "network utility packages";
      archive-packages.enable = mkEnableOption "archive utility packages";
      extra-packages.enable = mkEnableOption "extra packages";

      hyprland.enable = mkEnableOption "Hyprland WM";

      dev = {
        nix.enable = mkEnableOption "Nix development";
        python.enable = mkEnableOption "Python development";
        node.enable = mkEnableOption "Node development";
      };

      spotify.enable = mkEnableOption "Spotify";
    };
  };

  config = {
    modules.essential-packages.enable = mkDefault true;
    modules.network-packages.enable = mkDefault cfg.extra-packages.enable;
    modules.archive-packages.enable = mkDefault cfg.extra-packages.enable;

    modules.system-packages.enable = mkDefault (
      cfg.essential-packages.enable || cfg.extra-packages.enable
    );
  };
}
