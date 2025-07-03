{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Video acceleration packages for smooth media playback
    extraPackages = with pkgs; [
      libvdpau-va-gl # VDPAU support for video acceleration
      vaapiVdpau # VA-API to VDPAU bridge for browsers
    ];
  };

  # Environment variables for optimal media and GPU app performance
  environment.sessionVariables = {
    # Hardware video acceleration for browsers and media players
    LIBVA_DRIVER_NAME = "radeonsi"; # VA-API driver for Vega iGPU
    VDPAU_DRIVER = "radeonsi"; # VDPAU driver for video acceleration
  };
}
