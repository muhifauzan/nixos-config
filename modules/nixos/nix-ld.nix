{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules;

  langLdLibs = {
    python = pkgs.python3;
  };

  activeLdLibs = lib.foldlAttrs (
    acc: lang: pkgs:
    acc ++ lib.flatten (lib.optionals (lib.attrByPath [ lang "enable" ] false cfg.dev) pkgs)
  ) [ ] langLdLibs;

  ldRequired = activeLdLibs != [ ];
in
{
  config.programs.nix-ld = lib.mkIf ldRequired {
    enable = true;
    libraries = activeLdLibs;
  };
}
