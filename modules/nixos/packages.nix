{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config) username;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules;
in
{
  options = {
    modules.spotify.enable = mkEnableOption "Spotify";
  };

  config = mkIf cfg.spotify.enable {
    users.users.${username}.packages = [ pkgs.spotify ];

    networking.firewall = {
      # Sync local tracks from filesystem with mobile devices in the same network
      allowedTCPPorts = [ 57621 ];
      # Enable discovery of Google Cast devices in the same network
      allowedUDPPorts = [ 5353 ];
    };
  };
}
