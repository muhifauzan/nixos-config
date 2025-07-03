{ ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ./video.nix
    ./audio.nix
    ./nerdfonts.nix
    ./shell.nix
    ./etc-hosts.nix
    ./hyprland.nix
    ./container.nix
  ];
}
