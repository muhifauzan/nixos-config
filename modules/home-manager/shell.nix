{
  config,
  pkgs,
  lib,
  machine,
  ...
}:

let
  inherit (machine) hostname;
  colours = config.lib.stylix.colors.withHashtag;
in
{
  config = {
    programs = {
      zsh = {
        enable = true;

        plugins = with pkgs; [
          {
            name = zsh-vi-mode.pname;
            src = zsh-vi-mode.src;
          }

          {
            name = zsh-syntax-highlighting.pname;
            src = zsh-syntax-highlighting.src;
          }

          {
            name = zsh-autosuggestions.pname;
            src = zsh-autosuggestions.src;
          }

          {
            name = zsh-completions.pname;
            src = zsh-completions.src;
          }

          {
            name = zsh-you-should-use.pname;
            src = zsh-you-should-use.src;
          }

          {
            name = zsh-z.pname;
            src = zsh-z.src;
          }
        ];

        completionInit = "autoload -U compinit && compinit -u";

        initContent =
          let
            init = lib.mkOrder 500 ''
              export HOSTNAME=${hostname}
            '';

            zshZSettings = lib.mkOrder 1000 ''
              zstyle ':completion:*' menu select
            '';

            zshZvmEnv = lib.mkOrder 1000 ''
              ZVM_VI_HIGHLIGHT_BACKGROUND=${colours.base03}
              ZVM_VI_HIGHLIGHT_FOREGROUND=${colours.base05}
            '';
          in
          lib.mkMerge [
            init
            zshZSettings
            zshZvmEnv
          ];
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromTOML (builtins.readFile ./starship-settings.toml);
      };
    };
  };
}
