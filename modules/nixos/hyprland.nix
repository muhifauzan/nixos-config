{ pkgs, ... }:

{
  config = {
    programs = {
      hyprland = {
        enable = true;
        # Lets Hyprland launch via the Unified Wayland Session Manager (UWSM)
        withUWSM = true;
      };

      # For controlling backlight via Light
      light.enable = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];

      config = {
        common.default = [
          "hyprland"
        ];

        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];

          "org.freedesktop.impl.portal.FileChooser" = [
            "kde"
          ];
        };
      };
    };

    services = {
      displayManager = {
        defaultSession = "hyprland-uwsm";

        sddm = {
          # Enable SDDM as the graphical login manager
          enable = true;
          # Enable experimental Wayland support
          wayland.enable = true;
        };
      };
    };

    # Needed for some Wayland apps to behave properly with multi-monitor setups
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
