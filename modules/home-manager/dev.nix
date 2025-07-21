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
    {
      home.packages = [ pkgs.devenv ];

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    }

    (mkIf cfg.dev.nix.enable {
      home.packages = with pkgs; [
        nixfmt-rfc-style
        nixfmt-tree
      ];
    })

    (mkIf cfg.dev.elixir.enable {
      home.packages = [ pkgs.elixir ];
    })

    (mkIf cfg.dev.elixir.phoenix.enable {
      home.packages = [ pkgs.inotify-tools ];
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
