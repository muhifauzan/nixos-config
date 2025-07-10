{
  osConfig,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkMerge;
  cfg = osConfig.modules;
in
{
  config = mkMerge [
    (mkIf cfg.dev.nix.enable {
      home.packages = with pkgs; [
        nixfmt-rfc-style
        nixfmt-tree
      ];
    })
    (mkIf cfg.dev.node.enable {
      home.packages = [ pkgs.nodejs ];
      programs.bun.enable = true;
    })
    (mkIf cfg.dev.python.enable {
      home.packages = [ pkgs.python3 ];
      programs.uv.enable = true;
    })
  ];
}
