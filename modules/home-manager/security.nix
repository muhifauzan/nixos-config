{ machine, ... }:

let
  inherit (machine) user;
in
{
  sops = {
    defaultSopsFile = ../../.secrets/secrets.home-manager.yaml;
    age.keyFile = "${user.configHome}/age/home_manager.key";
  };
}
