{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      hyprpanel
    ];

    programs.hyprpanel = {
      enable = true;
      systemd.enable = true;
      # hyprland.enable = true;
      overwrite.enable = true;
      # settings = {
      #   bar.launcher.autoDetectIcon = true;
      #   bar.workspaces.show_icons = true;
      #   menu.clock = {
      #     time = {
      #       military = true;
      #       hideSeconds = true;
      #     };
      #     weather.unit = "metric";
      #   };
      #   menu.dashboard.directories.enabled = false;
      #   menu.dashboard.stats.enable_gpu = true;
      #   theme.bar.transparent = true;
      # };
    };
  };
}
