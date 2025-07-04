{
  osConfig,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkMerge mkIf;
  cfg = osConfig.modules;
in
{
  config = mkMerge [
    {
      # User-specific packages for development and workflow
      home.packages = with pkgs; [
        # System monitoring (modern alternatives)
        btop
        neofetch

        # Nix ecosystem tools
        nix-tree # Nix dependency explorer
        nix-output-monitor # Better nix build output

        # Development tools
        git-lfs # Git large file support

        # File management (modern alternatives)
        fd # Modern find alternative (complements fzf)
        duf # Modern df alternative
        dust # Modern du alternative

        # Media tools (complements your media consumption)
        ffmpeg # Video/audio processing
        imagemagick # Image processing

        # Archive tools (user-level)
        atool # Archive tool wrapper

        # JSON/YAML tools
        fx # Interactive JSON viewer
      ];

      programs = {
        firefox.enable = true;
        ripgrep.enable = true;
        ripgrep-all.enable = true;
      };
    }
    (mkIf cfg.extra-packages.enable {
      programs = {
        bat = {
          enable = true;

          config = {
            italic-text = "always";
            paging = "always";
            set-terminal-title = true;
            style = "full";
            wrap = "never";
          };
        };

        eza = {
          enable = true;
          enableZshIntegration = true;
          git = true;
          icons = "auto";
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
      };
    })
  ];
}
