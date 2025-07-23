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

    (lib.mkIf cfg.extra-packages.enable {
      environment.systemPackages = [ pkgs.lm_sensors ];
    })
  ];
}
