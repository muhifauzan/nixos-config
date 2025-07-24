{ config, lib, ... }:

let
  cfg = config.modules;
in
{
  imports = [ ./options ];

  options = {
    modules = {
      amd.enable = lib.mkEnableOption "AMD CPU and GPU settings";
      cpu.amd.enable = lib.mkEnableOption "AMD CPU settings";
      gpu.amd.enable = lib.mkEnableOption "AMD GPU settings";
      battery.enable = lib.mkEnableOption "battery settings";

      xdg.enable = lib.mkEnableOption "XDG management";

      packages = {
        admin.enable = lib.mkEnableOption "system administration and hardware diagnostic tools";
        extras.enable = lib.mkEnableOption "optional package collections";

        network.enable = lib.mkEnableOption "network utilities";
        archive.enable = lib.mkEnableOption "archive utilities";
        cli.enable = lib.mkEnableOption "CLI productivity tools";
      };

      hyprland.enable = lib.mkEnableOption "Hyprland WM";

      dev = {
        nix.enable = lib.mkEnableOption "Nix development";
        elixir.enable = lib.mkEnableOption "Elixir development";
        elixir.phoenix.enable = lib.mkEnableOption "Phoenix development";
        node.enable = lib.mkEnableOption "Node development";
        python.enable = lib.mkEnableOption "Python development";
      };

      ai.enable = lib.mkEnableOption "AI tooling";

      spotify.enable = lib.mkEnableOption "Spotify";
    };
  };

  config = {
    modules = {
      cpu.amd.enable = lib.mkDefault cfg.amd.enable;
      gpu.amd.enable = lib.mkDefault cfg.amd.enable;

      xdg.enable = lib.mkDefault true;

      packages = {
        admin.enable = lib.mkDefault true;
        network.enable = lib.mkDefault cfg.packages.extras.enable;
        archive.enable = lib.mkDefault cfg.packages.extras.enable;
        cli.enable = lib.mkDefault cfg.packages.extras.enable;
      };

      dev = {
        nix.enable = lib.mkDefault true;
        elixir.enable = lib.mkDefault cfg.dev.elixir.phoenix.enable;
      };
    };
  };
}
