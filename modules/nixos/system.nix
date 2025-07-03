{ ... }:

{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services = {
    # Time synchronization (hardware clock configured in configuration.nix)
    timesyncd.enable = true;

    # Firmware updates for security and performance
    fwupd.enable = true;

    # Thermal management to prevent overheating
    thermald.enable = true;

    # Laptop-optimized CPU frequency management
    auto-cpufreq = {
      enable = true;

      settings = {
        # Conservative battery settings for maximum battery life
        battery = {
          governor = "powersave";
          turbo = "never";
          # Let auto-cpufreq determine optimal frequencies for your CPU
        };

        # Performance when plugged in
        charger = {
          governor = "performance";
          turbo = "auto";
          # Use full CPU capabilities when charging
        };
      };
    };
  };

  # Power management - let auto-cpufreq handle CPU frequency
  powerManagement = {
    enable = true;
    # powertop recommendations for better power usage
    powertop.enable = true;
    # Note: cpuFreqGovernor is NOT set - auto-cpufreq handles this
  };
}
