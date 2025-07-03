{
  inputs,
  system,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland-config.nix
    ./hyprland-plugin.nix
  ];

  config = {
    home.packages = with pkgs; [
      kdePackages.dolphin
      rofi-wayland
    ];

    programs = {
      hyprpanel = {
        enable = true;
        systemd.enable = true;
      };

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

      plugins = with inputs.hyprland-plugins.packages.${system}; [
        hyprbars
        hyprexpo
      ];
    };

    services = {
      hyprpolkitagent.enable = true;
      mako.enable = false;
    };
  };
}
