{
  config,
  lib,
  machine,
  ...
}:

let
  inherit (lib) mkOption types;
  inherit (machine) user;

  cfg = config.modules;
in
{
  options.modules.my = {
    home = mkOption {
      type = types.str;
      default = "${user.homedir}/.my";
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
