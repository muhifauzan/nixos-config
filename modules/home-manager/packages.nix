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
      # User-specific packages for development and workflow
      home.packages = with pkgs; [
        # System monitoring (modern alternatives)
        btop

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

        bitwarden-desktop
      ];

      programs = {
        ripgrep.enable = true;
        ripgrep-all.enable = true;

        firefox = {
          enable = true;

          profiles.default = {
            id = 0;
            name = "default";
            path = "92oz7e9w.default";
            isDefault = true;

            extensions = {
              packages = with pkgs.nur.repos.rycee.firefox-addons; [
                bitwarden
                decentraleyes
                languagetool
                multi-account-containers
                privacy-badger
                search-by-image
                simple-tab-groups
                sponsorblock
                ublock-origin
                web-clipper-obsidian
              ];
            };
          };
        };
      };
    }

    (mkIf cfg.extra-packages.enable {
      home.packages = with pkgs; [
        fastfetch
      ];

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

        # TODO: make it dynamic based on zsh.enable config
        zsh.initContent = lib.mkOrder 1000 ''
          zvm_after_init_commands+=('source <(${pkgs.fzf}/bin/fzf --zsh)')
        '';
      };
    })
  ];
}
