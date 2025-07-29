{
  osConfig,
  lib,
  machine,
  ...
}:

let
  inherit (machine) user;
  cfg = osConfig.modules;
in
{
  config = lib.mkIf cfg.xdg.enable {
    xdg = {
      enable = true;
      dataHome = user.dataHome;
      stateHome = user.stateHome;
      configHome = user.configHome;
      cacheHome = user.cacheHome;

      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}
