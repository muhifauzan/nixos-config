{ pkgs, ... }:

{
  config = {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "elixir"
        "nix"
        "toml"
      ];

      extraPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
      ];

      package = pkgs.zed-editor;
    };

    nixGL.vulkan.enable = true;
    home.sessionVariables.VISUAL = "zeditor --new --wait";
  };
}
