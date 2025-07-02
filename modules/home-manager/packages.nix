{ ... }:

{
  config = {
    programs = {
      bat.enable = true;
      firefox.enable = true;
      ripgrep.enable = true;
      ripgrep-all.enable = true;

      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      vim = {
        enable = true;
        defaultEditor = true;
      };
    };
  };
}
