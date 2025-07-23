{ ... }:

# TODO: Might need to move some of it to machine specific settings
# TODO: Move security settings to security.nix
# TODO: Maybe move energy/power management settings to hardware/cpu.nix
# TODO: Explore TLP for charging limit
{
  services = {
    # Allow session software to update firmware
    fwupd.enable = true;

    # Time synchronization
    timesyncd.enable = true;

    # AMD Energy Performance Preference (EPP) manager
    auto-epp = {
      enable = true;

      settings = {
        Settings = {
          epp_state_for_AC = "balance_performance";
          epp_state_for_BAT = "balance_power";
        };
      };
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };
}
