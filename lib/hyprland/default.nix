{ lib, utils }:

{
  utils = import ./utils.nix { inherit lib utils; };
}
