{ ... }:

{
  # Auto-manager user service changes during rebuild
  systemd.user.startServices = "sd-switch";
}
