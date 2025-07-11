{
  pkgs,
  lib,
  machine,
  ...
}:

let
  inherit (lib) makeBinPath;
  inherit (machine) user;
in
{
  config = {
    virtualisation = {
      quadlet.enable = true;

      podman = {
        enable = true;
      };

      containers.storage.settings = {
        storage = {
          driver = "overlay";
          runroot = "/run/containers/storage";
          graphroot = "/var/lib/containers/storage";
        };
      };
    };

    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:${makeBinPath [ pkgs.bash ]}"
    '';

    users.users.${user.username} = {
      autoSubUidGidRange = true;
      linger = true;
    };
  };
}
