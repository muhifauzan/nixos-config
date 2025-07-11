{ config, lib, ... }:

let
  inherit (lib) mkDefault mkEnableOption;
  cfg = config.modules;
in
{
  options = {
    modules = {
      essential-packages.enable = mkEnableOption "essential packages";
      system-packages.enable = mkEnableOption "system utility packages";
      network-packages.enable = mkEnableOption "network utility packages";
      archive-packages.enable = mkEnableOption "archive utility packages";
      extra-packages.enable = mkEnableOption "extra packages";

      dev = {
        nix.enable = mkEnableOption "nix development";
        python.enable = mkEnableOption "python development";
        node.enable = mkEnableOption "node development";
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
