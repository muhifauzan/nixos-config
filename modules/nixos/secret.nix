{ config, ... }:

let
  cfg = config.modules;
in
{
  sops = {
    defaultSopsFile = ../../.secrets/secrets.nixos.yaml;
    age.keyFile = "${cfg.my.keyHome}/age/nixos.key";
  };
}
