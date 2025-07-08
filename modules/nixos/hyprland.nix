{ pkgs, inputs, ... }:

let
  hyprlandPackages = inputs.hyprland.packages.${pkgs.system};
in
{
  config = {
    programs = {
      hyprland = {
        enable = true;

        # Include the system's bin path to systemd
        # Already set to true by default for version >= 0.41.2,
        # but just want to make sure
        systemd.setPath.enable = true;

        # Lets Hyprland launch via the Unified Wayland Session Manager (UWSM)
        withUWSM = true;

        # Use the one from flake
        package = hyprlandPackages.hyprland;
      };

      # For controlling backlight via Light
      light.enable = true;
    };

    services = {
      displayManager = {
        enable = true;
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
