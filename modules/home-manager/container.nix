{ machine, ... }:

let
  inherit (machine) user;
in
{
  config = {
    services.podman = {
      enable = true;
      settings.storage = {
        storage = {
          driver = "overlay";
          runroot = "/run/user/1000/containers";
          graphroot = "${user.homedir}/.local/share/containers/storage";
        };
      };
    };

    systemd.user.startServices = "sd-switch";
  };
}
