{ pkgs, ... }:

{
  config = {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "elixir"
        "nix"
      ];

      extraPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
      ];
    };

    nixGL.vulkan.enable = true;

    home.sessionVariables.VISUAL = "zeditor";
  };
}
