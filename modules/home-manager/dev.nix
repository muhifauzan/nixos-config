{
  osConfig,
  pkgs,
  lib,
  ...
}:

let
  cfg = osConfig.modules;
in
{
  config = lib.mkMerge [
    {
      home.packages = [ pkgs.devenv ];

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    }

    (lib.mkIf cfg.dev.nix.enable {
      home.packages = with pkgs; [
        nixfmt-rfc-style
        nixfmt-tree
      ];
    })

    (lib.mkIf cfg.dev.elixir.enable {
      home.packages = [ pkgs.elixir ];
    })

    (lib.mkIf cfg.dev.elixir.phoenix.enable {
      home.packages = [ pkgs.inotify-tools ];
    })

    (lib.mkIf cfg.dev.node.enable {
      home.packages = [ pkgs.nodejs ];
      programs.bun.enable = true;
    })

    (lib.mkIf cfg.dev.python.enable {
      home.packages = [ pkgs.python3 ];
      programs.uv.enable = true;
    })
  ];
}
