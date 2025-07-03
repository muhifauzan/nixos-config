{ pkgs, lib, ... }:

let
  # gruvboxRainbowPreset = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/starship/starship/refs/tags/v1.23.0/docs/public/presets/toml/gruvbox-rainbow.toml";
  #   sha256 = "sha256-AwdWRDPt9MH5+bwQNbqvLgs+dTKjGctci1XhDn8XXGo=";
  # };

  catppuccinPowerlinePreset = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/starship/starship/refs/tags/v1.23.0/docs/public/presets/toml/catppuccin-powerline.toml";
    sha256 = "sha256-IV9+UREl+UMN1Lt4rcTrtajyfoWKSz7yz0xim8y5kkg=";
  };
in
{
  config = {
    programs = {
      zsh = {
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

      starship = {
        enable = true;
        enableZshIntegration = true;
        # settings = builtins.fromTOML (builtins.readFile gruvboxRainbowPreset);
        settings = builtins.fromTOML (builtins.readFile catppuccinPowerlinePreset);
      };
    };
  };
}
