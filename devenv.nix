{
  dotenv.enable = true;

  scripts.sops-edit-nixos.exec = ''
    export SOPS_AGE_KEY_FILE=$XDG_CONFIG_HOME/age/nixos.key
    sops edit .secrets/secrets.nixos.yaml
  '';

  scripts.sops-edit-home-manager.exec = ''
    export SOPS_AGE_KEY_FILE=$XDG_CONFIG_HOME/age/home_manager.key
    sops edit .secrets/secrets.home-manager.yaml
  '';

  scripts.sops-info.exec = ''
    echo "Available SOPS scripts:"
    echo "  sops-edit-nixos        - Edit NixOS secrets"
    echo "  sops-edit-home-manager - Edit Home Manager secrets"
  '';
}
