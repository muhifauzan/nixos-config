{ ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ./video.nix
    ./audio.nix
    ./shell.nix
    ./hyprland.nix
    ./container.nix
  ];
}
