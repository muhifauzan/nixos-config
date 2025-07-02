{ inputs, system, ... }:

{
  config = {
    home.packages = [
      inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    ];
  };
}
