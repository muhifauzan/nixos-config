{ config, lib, ... }:

let
  inherit (lib)
    filter
    length
    literalExpression
    mkOption
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
            example = "DP-1";
            description = "Monitor identifier";
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
            description = "Monitor position in 'virtual display' (e.g., '0x0', '1920x0', 'auto')";
          };

          scale = mkOption {
            type = types.either types.float types.ints.positive;
            default = 1;
            example = 1.5;
            description = "Display scaling factor";
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

  config.assertions = [
    {
      assertion =
        ((length cfg.monitors) != 0) -> ((length (filter (monitor: monitor.primary) cfg.monitors)) == 1);
      message = ''
        Exactly one monitor must be set to primary when monitors are configured.

        Assign `primary = true` to exactly one monitor in your configuration.
      '';
    }
  ];
}
