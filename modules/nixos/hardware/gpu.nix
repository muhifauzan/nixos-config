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
  config = lib.mkIf cfg.isAmdGpu {
    hardware.amdgpu = {
      # Load AMD kernel module in stage 1
      # Can fix lower resolution in boot screen during initramfs
      initrd.enable = true;

      # OpenCL support via ROCm
      opencl.enable = true;

      # AMD open source driver for Vulkan
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        supportExperimental.enable = true;
      };
    };

    # AMD GPU utilities, amdgpu_top
    environment.systemPackages = lib.optionals cfg.extra-packages.enable [ pkgs.amdgpu_top ];
  };
}
