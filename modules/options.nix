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
      xdg.enable = mkEnableOption "XDG management";

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

      ai.enable = mkEnableOption "AI tooling";

      spotify.enable = mkEnableOption "Spotify";
    };
  };

  config = {
    modules = {
      xdg.enable = mkDefault true;

      essential-packages.enable = mkDefault true;
      network-packages.enable = mkDefault cfg.extra-packages.enable;
      archive-packages.enable = mkDefault cfg.extra-packages.enable;

      system-packages.enable = mkDefault (cfg.essential-packages.enable || cfg.extra-packages.enable);
    };
  };
}
