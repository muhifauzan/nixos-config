{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    zed-editor
  ];

  nixGL.vulkan.enable = true;
}
