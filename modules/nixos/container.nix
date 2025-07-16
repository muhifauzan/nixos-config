{ pkgs, machine, ... }:

let
  inherit (machine) user;
in
{
  config = {
    environment.systemPackages = [ pkgs.podman-compose ];

    virtualisation = {
      podman = {
        enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      quadlet.enable = true;

      containers.storage.settings = {
        storage = {
          driver = "overlay";
          graphroot = "/var/lib/containers/storage";
          runroot = "/run/containers/storage";
        };
      };
    };

    users.users.${user.username} = {
      autoSubUidGidRange = true;
      linger = true;
    };
  };
}
