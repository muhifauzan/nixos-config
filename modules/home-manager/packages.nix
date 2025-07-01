{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    vim
  ];

  services.podman.enable = true;
}
