{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) optionals;
  cfg = config.modules;
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages =
    with pkgs;
    optionals cfg.extra-packages.enable [
      # Mesa utilities, glxinfo, glxgears, es2_info, es2gears
      mesa-demos

      # Vulkan utilities, vulkaninfo, vkcube, vkcubepp
      vulkan-tools
    ];
}
