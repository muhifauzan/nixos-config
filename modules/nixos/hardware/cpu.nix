{ config, lib, ... }:

let
  inherit (lib) mkIf;
  cfg = config.modules;
in
{
  config = mkIf cfg.isAmdCpu {
    hardware.cpu.amd.updateMicrocode = true;

    boot = {
      extraModulePackages = [ config.boot.kernelPackages.zenpower ];
      blacklistedKernelModules = [ "k10temp" ];

      kernelModules = [
        "kvm-amd"
        "zenpower"
      ];
    };
  };
}
