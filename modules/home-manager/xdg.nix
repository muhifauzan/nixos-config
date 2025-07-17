{
  osConfig,
  lib,
  machine,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (machine) user;

  cfg = osConfig.modules;
in
{
  config = mkIf cfg.xdg.enable {
    xdg = {
      enable = true;
      dataHome = user.dataHome;
      stateHome = user.stateHome;
      configHome = user.configHome;
      cacheHome = user.cacheHome;
    };
  };
}
