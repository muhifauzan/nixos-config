{ pkgs, ... }:

{
  options = {};

  config = {
    home.packages = with pkgs; [
      kitty
    ];
  };
}

