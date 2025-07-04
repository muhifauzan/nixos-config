{
  user,
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkDefault
    mkMerge
    mkIf
    ;
  cfg = config.modules;
in
{
  options = {
    modules = {
      essential-packages.enable = mkEnableOption "essential packages";
      system-packages.enable = mkEnableOption "system utility packages";
      network-packages.enable = mkEnableOption "network utility packages";
      archive-packages.enable = mkEnableOption "archive utility packages";
      extra-packages.enable = mkEnableOption "extra packages";
      spotify.enable = mkEnableOption "Spotify";
    };
  };

  config = mkMerge [
    {
      modules.essential-packages.enable = mkDefault true;
      modules.network-packages.enable = mkDefault cfg.extra-packages.enable;
      modules.archive-packages.enable = mkDefault cfg.extra-packages.enable;

      modules.system-packages.enable = mkDefault (
        cfg.essential-packages.enable || cfg.extra-packages.enable
      );
    }
    (mkIf cfg.system-packages.enable {
      environment.systemPackages = with pkgs; [
        dmidecode
        file
        htop
        lshw
        pciutils
        usbutils
      ];
    })
    (mkIf cfg.network-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        curl
        dig
        netcat
        nmap
        wget
      ];
    })
    (mkIf cfg.archive-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        p7zip
        unzip
        zip
      ];
    })
    (mkIf cfg.extra-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        jq
        tree
        yq-go
      ];
    })
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
