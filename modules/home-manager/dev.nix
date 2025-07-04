{
  osConfig,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkIf;
  cfg = osConfig.modules;
in
{
  config = mkIf cfg.dev.nix.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nixfmt-tree
    ];
  };
}
