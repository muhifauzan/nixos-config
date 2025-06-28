{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    # Lets Hyprland launch via the Unified Wayland Session Manager (UWSM)
    withUWSM = true;
  };

  # For controlling backlight via Light
  programs.light.enable = true;

  security.polkit.enable = true;

  services.displayManager = {
    defaultSession = "hyprland-uwsm";

    sddm = {
      # Enable SDDM as the graphical login manager
      enable = true;
      # Enable experimental Wayland support
      wayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
  ];

  # Needed for some Wayland apps to behave properly with multi-monitor setups
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

