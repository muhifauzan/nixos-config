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
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages =
    with pkgs;
    lib.optionals cfg.packages.admin.enable [
      # Mesa utilities, glxinfo, glxgears, es2_info, es2gears
      mesa-demos

      # Vulkan utilities, vulkaninfo, vkcube, vkcubepp
      vulkan-tools
    ];
}
