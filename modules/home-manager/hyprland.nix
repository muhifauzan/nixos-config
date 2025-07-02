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
      kitty
      wofi
    ];

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
