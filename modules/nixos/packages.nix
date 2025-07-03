{ config, pkgs, ... }:

{
  config = {
    users.users.${config.username}.packages = with pkgs; [
      spotify
    ];

    networking.firewall = {
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 5353 ];
    };
  };
}
