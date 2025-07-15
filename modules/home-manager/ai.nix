{
  osConfig,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkIf;

  cfg = osConfig.modules;
  claudeDesktopPackages = inputs.claude-desktop.packages.${pkgs.system};
in
{
  config = mkIf cfg.ai.enable {
    home.packages = with pkgs; [
      mcp-proxy
      claudeDesktopPackages.claude-desktop
    ];
  };
}
