{ machine, inputs, ... }:

let
  inherit (machine) system;
in
{
  config = {
    home.packages = [
      inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    ];
  };
}
