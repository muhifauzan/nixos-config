{
  osConfig,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  cfg = osConfig.modules;
  claudeDesktopPackages = inputs.claude-desktop.packages.${pkgs.system};
in
{
  config = lib.mkIf cfg.ai.enable {
    home.packages = with pkgs; [
      mcp-proxy
      claudeDesktopPackages.claude-desktop
    ];
  };
}
