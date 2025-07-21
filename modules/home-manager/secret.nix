{
  osConfig,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkOrder;

  cfg = osConfig.modules;
in
{
  sops = {
    defaultSopsFile = ../../.secrets/secrets.home-manager.yaml;
    age.keyFile = "${cfg.my.keyHome}/age/home_manager.key";

    secrets = {
      anthropic_api_key = { };
      openai_api_key = { };
      onemap_username = { };
      onemap_password = { };
    };
  };

  home.file."${cfg.my.scriptHome}/sops-nix/load-secrets.sh" = {
    text = ''
      #!/usr/bin/env bash
      # export <SOME_ENV>=$(cat $SOPS_<SOME_ENV>_PATH 2>/dev/null || echo "")
      export SOPS_ANTHROPIC_API_KEY_PATH=${config.sops.secrets.anthropic_api_key.path}
      export SOPS_OPENAI_API_KEY_PATH=${config.sops.secrets.openai_api_key.path}
      export SOPS_ONEMAP_USERNAME_PATH=${config.sops.secrets.onemap_username.path}
      export SOPS_ONEMAP_PASSWORD_PATH=${config.sops.secrets.onemap_password.path}
    '';

    executable = true;
  };

  # TODO: Make zsh options configurable
  programs.zsh.initContent = mkOrder 1500 ''
    source ${cfg.my.scriptHome}/sops-nix/load-secrets.sh
  '';
}
