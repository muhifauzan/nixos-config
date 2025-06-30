{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    zed-editor
  ];

  nixGL.vulkan.enable = true;
}
