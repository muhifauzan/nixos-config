{ ... }:

{
  config = {
    services.podman = {
      enable = true;

      settings.storage = {
        storage = {
          driver = "overlay";

          # TODO: Figure out how to fix/coexist with bubblewrap
          # Setting up graphroot cause bubblewrap app to use its own graphroot path
          # which I don't know where, which change the rootless podman SUID/SGID mapping
          # which cause error with layer something which can only be solved with
          # podman system migrate
          graphroot = "$XDG_DATA_HOME/containers/storage";

          runroot = "$XDG_RUNTIME_DIR/containers/storage";
        };
      };
    };
  };
}
