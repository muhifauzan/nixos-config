{ lib }:

rec {
  utils = import ./utils.nix { inherit lib; };
  hyprland = import ./hyprland { inherit lib utils; };
}
