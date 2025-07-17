{ config, machine, ... }:

let
  inherit (machine) user;
in
{
  sops = {
    defaultSopsFile = ../../.secrets/secrets.home-manager.yaml;
    age.keyFile = "${user.configHome}/age/home_manager.key";

    secrets = {
      anthropic_api_key = { };
      openai_api_key = { };
      onemap_username = { };
      onemap_password = { };
    };
  };

  home.file.".config/sops-nix/load-secrets.sh" = {
    text = ''
      #!/usr/bin/env bash

      export ANTHROPIC_API_KEY=$(cat "${config.sops.secrets.anthropic_api_key.path}" 2>/dev/null || echo "")
      export OPENAI_API_KEY=$(cat "${config.sops.secrets.openai_api_key.path}" 2>/dev/null || echo "")
      export ONEMAP_USERNAME=$(cat "${config.sops.secrets.onemap_username.path}" 2>/dev/null || echo "")
      export ONEMAP_PASSWORD=$(cat "${config.sops.secrets.onemap_password.path}" 2>/dev/null || echo "")
    '';

    executable = true;
  };

  # TODO: Make zsh configurable
  programs.zsh.initExtra = ''
    source ${user.configHome}/sops-nix/load-secrets.sh
  '';
}
