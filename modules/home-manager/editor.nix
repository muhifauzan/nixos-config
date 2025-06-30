{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    zed-editor
  ];

  nixGL.vulkan.enable = true;
}
