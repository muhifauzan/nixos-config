{ ... }:

{
  config = {
    # home.packages = with pkgs; [
    #   nixd
    #   nixfmt-rfc-style
    # ];

    programs.zed-editor = {
      enable = true;

      extensions = [
        "elixir"
        "nix"
      ];
    };

    nixGL.vulkan.enable = true;
  };
}
