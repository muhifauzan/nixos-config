{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules;
in
{
  hardware.graphics = {
    extraPackages = with pkgs; [
      # VA-API (Video Acceleration API)
      libva

      # VDPAU driver with OpenGL/VA-API backend
      libvdpau-va-gl

      # VDPAU to VA-API bridge (fallback)
      vaapiVdpau
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  # VA-API utilities, vainfo, vaapi-fits
  environment.systemPackages = lib.optionals cfg.extra-packages.enable [ pkgs.libva-utils ];

  environment.sessionVariables = lib.mkMerge [
    {
      # Enable MPEG-4 Part 2 for VA-API
      # Warning: VA-API has limitations with this feature
      # VAAPI_MPEG4_ENABLED = true;
    }

    (lib.mkIf cfg.isAmdGpu {
      # Force-enable Vulkan Video support for older AMD GPU cards
      # RADV_PERFTEST = "video_decode,video_encode";

      # VA-API driver for AMD GPU driver
      LIBVA_DRIVER_NAME = "radeonsi";

      # VDPAU driver for AMD GPU driver
      VDPAU_DRIVER = "radeonsi";
    })
  ];
}
