{ ... }:

{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    # Time synchronization
    timesyncd.enable = true;

    # Firmware updates for security and performance
    fwupd.enable = true;

    # Thermal management (important for high-performance mobile CPU)
    thermald.enable = true;

    # AMD Energy Performance Preference - optimal for Zen 3
    auto-epp = {
      enable = true;

      settings = {
        Settings = {
          # Balanced approach: performance when needed, efficiency on battery
          epp_state_for_AC = "performance"; # Full power when plugged in
          epp_state_for_BAT = "balance_power"; # Balanced battery life
        };
      };
    };
  };

  # Power management optimizations
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
