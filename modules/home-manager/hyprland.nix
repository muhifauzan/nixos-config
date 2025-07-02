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
    # ./hyprland-hyprpanel.nix
  ];

  config = {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];

    programs = {
      wofi.enable = true;

      hyprpanel = {
        enable = true;
        systemd.enable = true;
      };

      kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
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
