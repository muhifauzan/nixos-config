{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  cfg = config.modules;
in
{
  options.modules.my = {
    home = mkOption {
      type = types.str;
      default = ".my";
    };

    scriptHome = mkOption {
      type = types.str;
      default = "${cfg.my.home}/scripts";
    };

    keyHome = mkOption {
      type = types.str;
      default = "${cfg.my.home}/keys";
    };
  };
}
