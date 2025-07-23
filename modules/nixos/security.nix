{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
}
