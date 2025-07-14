{ osConfig, lib, ... }:

let
  inherit (lib) mkIf;
  cfg = osConfig.modules;
in
{
  config = mkIf cfg.xdg.enable {
    xdg.enable = true;
  };
}
