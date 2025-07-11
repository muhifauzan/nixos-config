{ config, lib, ... }:

let
  inherit (lib)
    filter
    length
    literalExpression
    mkOption
    optionals
    types
    ;

  cfg = config.modules;
in
{
  options.modules.monitors = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "eDP-1";
            description = ''Monitor identifier (e.g., `"eDP-1"`, `"DP-1"`, `"HDMI-A-1"`)'';
          };

          width = mkOption {
            type = types.ints.positive;
            example = 1920;
            description = "Monitor width in pixels";
          };

          height = mkOption {
            type = types.ints.positive;
            example = 1080;
            description = "Monitor height in pixels";
          };

          refreshRate = mkOption {
            type = types.ints.positive;
            default = 60;
            example = 144;
            description = "Monitor refresh rate in Hz";
          };

          position = mkOption {
            type = types.str;
            default = "auto";
            example = "1920x0";
            description = ''
              Monitor position in the virtual display coordinate system.

              Supported generic formats (compatible across display systems):
              - Coordinates: `"1920x0"`, `"0x-1080"` (X and Y pixel positions)
              - `"auto"`: Automatic placement to the right of existing monitors

              Note: Advanced positioning features are available via system-specific
              extensions (e.g., `hyprland.position` for Hyprland-specific position variants).

              For SDDM login screen: Uses standard X11 coordinate system.
              For Hyprland: Can be overridden by `hyprland.position` for advanced features.
            '';
          };

          scale = mkOption {
            type = types.numbers.positive;
            default = 1;
            example = 2;
            description = "Display scaling factor (e.g., `1`, `1.5`, `2`)";
          };

          primary = mkOption {
            type = types.bool;
            default = false;
            description = "Whether this monitor is the primary display";
          };

          disabled = mkOption {
            type = types.bool;
            default = false;
            description = "Whether this monitor is disabled";
          };
        };
      }
    );

    default = [ ];

    example = literalExpression ''
      [
        {
          name = "eDP-1";
          width = 1920
          height = 1080;
          refreshRate = 60;
          primary = true;
        }
      ]
    '';

    description = ''
      Monitor configurations with base options.

      Additional options can be added by desktop environment modules.
    '';
  };

  config.assertions = optionals ((length cfg.monitors) != 0) [
    {
      assertion = (length (filter (m: m.primary) cfg.monitors)) == 1;
      message = ''
        Exactly one monitor must be set to primary when monitors are configured.

        Assign `primary = true` to exactly one monitor in your configuration.
      '';
    }

    {
      assertion = (length (filter (m: !m.disabled) cfg.monitors)) >= 1;
      message = ''
        At least one monitor must be enabled when monitors are configured.

        Set `disabled = false` for at least one monitor in your configuration.
      '';
    }

    (
      let
        invalidScales = (filter (m: m.scale <= 0 || m.scale > 10) cfg.monitors);
      in
      {
        assertion = (length invalidScales) == 0;
        message = ''
          Monitor scale values must be between 0.1 and 10.

          Invalid monitors: ${toString (map (m: "${m.name} (${toString m.scale})") invalidScales)}
        '';
      }
    )

    (
      let
        invalidResolutions = filter (m: m.width < 320 || m.height < 240) cfg.monitors;
      in
      {
        assertion = (length invalidResolutions) == 0;
        message = ''
          Monitor resolution must be at least 320x240 pixels.

          Invalid monitors: ${
            toString (map (m: "${m.name} (${toString m.width}x${toString m.height})") invalidResolutions)
          }
        '';
      }
    )

    (
      let
        invalidRefreshRates = filter (m: m.refreshRate < 30 || m.refreshRate > 500) cfg.monitors;
      in
      {
        assertion = (length invalidRefreshRates) == 0;
        message = ''
          Monitor refresh rate must be between 30Hz and 500Hz.

          Invalid monitors: ${
            toString (map (m: "${m.name} (${toString m.refreshRate}Hz)") invalidRefreshRates)
          }
        '';
      }
    )
  ];
}
