{ pkgs, machine, ... }:

let
  inherit (machine) user;
in
{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops = {
    defaultSopsFile = ../../.secrets/secrets.nixos.yaml;
    age.keyFile = "${user.configHome}/age/nixos.key";
  };
}
