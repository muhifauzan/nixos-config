{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib)
    attrByPath
    flatten
    foldlAttrs
    mkIf
    optionals
    ;

  cfg = config.modules;

  langLdLibs = {
    python = pkgs.python3;
  };

  activeLdLibs = foldlAttrs (
    acc: lang: pkgs:
    acc ++ flatten (optionals (attrByPath [ lang "enable" ] false cfg.dev) pkgs)
  ) [ ] langLdLibs;

  ldRequired = activeLdLibs != [ ];
in
{
  config.programs.nix-ld = mkIf ldRequired {
    enable = true;
    libraries = activeLdLibs;
  };
}
