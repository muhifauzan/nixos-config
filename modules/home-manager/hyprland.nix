{ pkgs, ... }:

{
  options = { };

  config = {
    home.packages = with pkgs; [ kitty ];

    services = {
      mako.enable = true;
      hyprpolkitagent.enable = true;
    };
  };
}

