{ ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ./video.nix
    ./audio.nix
    ./nerdfonts.nix
    ./shell.nix
    ./container.nix
    ./etc-hosts.nix
    ./hyprland.nix
    ./packages.nix
  ];
}
