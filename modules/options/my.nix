{
  config,
  lib,
  machine,
  ...
}:

let
  inherit (lib) types;
  inherit (machine) user;

  cfg = config.modules;
in
{
  options.modules.my = {
    home = lib.mkOption {
      type = types.str;
      default = "${user.homedir}/.my";
    };

    scriptHome = lib.mkOption {
      type = types.str;
      default = "${cfg.my.home}/scripts";
    };

    keyHome = lib.mkOption {
      type = types.str;
      default = "${cfg.my.home}/keys";
    };
  };
}
