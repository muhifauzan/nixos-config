{ inputs, system, ... }:

{
  home.packages = [
    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
  ];
}
