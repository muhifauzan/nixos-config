{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];

    programs.zed-editor.enable = true;

    nixGL.vulkan.enable = true;
  };
}
