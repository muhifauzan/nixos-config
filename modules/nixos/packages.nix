{
  user,
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.modules;
in
{
  options = {
    modules.spotify.enable = mkEnableOption "Spotify";
  };

  config = mkMerge [
    {
      environment.systemPackages = with pkgs; [
        curl
        dig
        dmidecode
        file
        htop
        jq
        lshw
        netcat
        nmap
        pciutils
        p7zip
        tree
        unzip
        usbutils
        wget
        yq-go
        zip
      ];
    }
    (mkIf cfg.spotify.enable {
      users.users.${user.username}.packages = [ pkgs.spotify ];

      networking.firewall = {
        # Sync local tracks from filesystem with mobile devices in the same network
        allowedTCPPorts = [ 57621 ];
        # Enable discovery of Google Cast devices in the same network
        allowedUDPPorts = [ 5353 ];
      };
    })
  ];
}
