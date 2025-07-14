{ machine, ... }:

let
  inherit (machine) user;
in
{
  config = {
    virtualisation = {
      podman.enable = true;
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
