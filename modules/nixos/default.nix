{ ... }:

{
  imports = [
    ./..
    ./nix.nix
    ./hardware.nix
    ./system.nix
    ./video.nix
    ./audio.nix
    ./shell.nix
    ./container.nix
    ./etc-hosts.nix
    ./packages.nix
    ./nix-ld.nix
    ./nerdfonts.nix
    ./hyprland.nix
  ];
}
