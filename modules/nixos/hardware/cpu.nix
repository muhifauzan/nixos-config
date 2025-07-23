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
  config = lib.mkMerge [
    {
      # Hardware diagnostic utilities, sensors
      environment.systemPackages = lib.optionals cfg.packages.admin.enable [ pkgs.lm_sensors ];
    }

    (lib.mkIf cfg.cpu.amd.enable {
      hardware.cpu.amd.updateMicrocode = true;

      boot = {
        extraModulePackages = [ config.boot.kernelPackages.zenpower ];
        blacklistedKernelModules = [ "k10temp" ];

        kernelModules = [
          "kvm-amd"
          "zenpower"
        ];
      };
    })
  ];
}
