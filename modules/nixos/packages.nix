{
  config,
  lib,
  pkgs,
  machine,
  ...
}:

let
  inherit (machine) user;
  cfg = config.modules;
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.system-packages.enable {
      environment = {
        systemPackages = with pkgs; [
          dmidecode
          file
          htop
          less
          lshw
          pciutils
          usbutils
        ];

        variables = {
          LESS = "-iMRSW";
          PAGER = "less";
        };
      };

      programs.vim = {
        enable = true;
        defaultEditor = true;
      };
    })

    (lib.mkIf cfg.network-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        curl
        dig
        netcat
        nmap
        wget
      ];
    })

    (lib.mkIf cfg.archive-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        p7zip
        unzip
        zip
      ];
    })

    (lib.mkIf cfg.extra-packages.enable {
      users.users.${user.username}.packages = with pkgs; [
        jq
        tree
        yq-go
      ];
    })

    (lib.mkIf cfg.hyprland.enable {
      environment.systemPackages = with pkgs; [
        brightnessctl
        playerctl
        wireplumber
      ];
    })

    (lib.mkIf cfg.spotify.enable {
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
