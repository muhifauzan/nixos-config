{ pkgs, inputs, ... }:

let
  claudeDesktopPackages = inputs.claude-desktop.packages.${pkgs.system};
in
{
  config = {
    home.packages = [
      claudeDesktopPackages.claude-desktop-with-fhs
    ];
  };
}
