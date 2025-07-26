{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darktooth.yaml";

    override = {
      # Background
      base00 = "#282828";

      # Soft background
      base01 = "#3C3836";

      # Light background
      base02 = "#504945";

      # Dark foreground
      base03 = "#665C54";

      # Muted foreground
      base04 = "#928374";

      # Foreground
      base05 = "#FDF4C1";

      # Soft foreground
      base06 = "#EBDBB2";

      # Light foreground
      base07 = "#D5C4A1";

      # Red
      base08 = "#9D0006";

      # Orange
      base09 = "#AF3A03";

      # Yellow
      base0A = "#B57614";

      # Green
      base0B = "#79740E";

      # Cyan
      base0C = "#00A7AF";

      # Blue
      base0D = "#076678";

      # Magenta
      base0E = "#8F3F71";

      # Brown
      base0F = "#427B58";
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
    };

    polarity = "dark";
  };
}
