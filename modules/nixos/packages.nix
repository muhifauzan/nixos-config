{ config, pkgs, ... }:

{
  config = {
    users.users.${config.username}.packages = with pkgs; [
      spotify
    ];
  };
}
