{ config, lib, ... }:

let
  cfg = config.modules;
in
{
  imports = [
    ./options
  ];

  options = {
    modules = {
      amd.enable = lib.mkEnableOption "AMD CPU and GPU settings";
      cpu.amd.enable = lib.mkEnableOption "AMD CPU settings";
      gpu.amd.enable = lib.mkEnableOption "AMD GPU settings";
      battery.enable = lib.mkEnableOption "battery settings";

      xdg.enable = lib.mkEnableOption "XDG management";

      essential-packages.enable = lib.mkEnableOption "essential packages";
      system-packages.enable = lib.mkEnableOption "system utility packages";
      network-packages.enable = lib.mkEnableOption "network utility packages";
      archive-packages.enable = lib.mkEnableOption "archive utility packages";
      extra-packages.enable = lib.mkEnableOption "extra packages";

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

      essential-packages.enable = lib.mkDefault true;
      network-packages.enable = lib.mkDefault cfg.extra-packages.enable;
      archive-packages.enable = lib.mkDefault cfg.extra-packages.enable;

      system-packages.enable = lib.mkDefault (cfg.essential-packages.enable || cfg.extra-packages.enable);

      dev = {
        nix.enable = lib.mkDefault true;
        elixir.enable = lib.mkDefault cfg.dev.elixir.phoenix.enable;
      };
    };
  };
}
