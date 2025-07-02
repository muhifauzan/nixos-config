{ pkgs, lib, ... }:

{
  config = {
    programs.zsh = {
      enable = true;

      plugins = with pkgs; [
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

      initContent = lib.mkOrder 1000 ''
        autoload -U compinit && compinit -u
        zstyle ':completion:*' menu select
      '';
    };
  };
}
