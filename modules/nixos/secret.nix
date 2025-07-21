{ machine, ... }:

let
  inherit (machine) user;
in
{
  sops = {
    defaultSopsFile = ../../.secrets/secrets.nixos.yaml;
    age.keyFile = "${user.configHome}/age/nixos.key";
  };
}
