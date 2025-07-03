{ lib, config, ... }:

{
  hardware = {
    # Essential firmware and Bluetooth
    enableRedistributableFirmware = true;
    bluetooth.enable = true;

    # AMD CPU optimizations
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # AMD Vega iGPU optimizations
    amdgpu = {
      # Load AMD GPU driver early for faster boot
      initrd.enable = true;

      # OpenCL for GPU-accelerated applications
      opencl.enable = true;

      # Vulkan drivers for gaming and GPU apps
      amdvlk = {
        enable = true;
        support32Bit.enable = true; # For Steam and 32-bit games
      };
    };
  };
}
