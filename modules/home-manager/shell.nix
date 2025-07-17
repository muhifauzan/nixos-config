{
  pkgs,
  lib,
  machine,
  ...
}:

let
  inherit (lib) mkMerge mkOrder;
  inherit (machine) hostname;
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

        completionInit = '''';

        initContent =
          let
            init = mkOrder 500 ''
              export HOSTNAME=${hostname}
            '';

            config = mkOrder 1000 ''
              autoload -U compinit && compinit -u
              zstyle ':completion:*' menu select
            '';
          in
          mkMerge [
            init
            config
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
