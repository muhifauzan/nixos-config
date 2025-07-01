{
  inputs,
  system,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland-config.nix
    ./hyprland-plugin-config.nix
    # ./hyprland-hyprpanel.nix
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

  home.packages = with pkgs; [
    kdePackages.dolphin
    kitty
    wofi
  ];
}
