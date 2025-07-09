{ config, lib, ... }:

let
  inherit (lib)
    filter
    length
    mkOption
    types
    ;

  cfg = config.modules;
in
# "monitor" = [
#   "eDP1, preferred, auto, auto"
#
#   "desc:Monitor Description, preferred, auto, auto"
#
#   "eDP1, highres@60, auto, auto"
#   "eDP1, maxwidth@60, auto, auto"
#   "eDP1, 1920x1080@highrr, auto, auto"
#
#   "eDP1, preferred, auto, auto"
#   "eDP1, preferred, auto-right, auto"
#   "eDP1, preferred, auto-left, auto"
#   "eDP1, preferred, auto-up, auto"
#   "eDP1, preferred, auto-down, auto"
#   "eDP1, preferred, auto-center-right, auto"
#   "eDP1, preferred, auto-center-left, auto"
#   "eDP1, preferred, auto-center-up, auto"
#   "eDP1, preferred, auto-center-down, auto"
#
#   "eDP1, disable"
# ];
{
  options.modules.monitors = mkOption {
    description = "Monitor configurations";

    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.oneOf [
              types.str

              (types.submodule {
                options = {
                  desc = mkOption {
                    type = types.str;
                    description = "Monitor `description` value up to, but not including the portname";
                  };
                };
              })
            ];

            example = "DP-1";

            description = ''
              Monitor identifier.

              Example:
              - "eDP-1"
              - { desc = "Monitor One"; }
            '';
          };

          primary = mkOption {
            type = types.bool;
            default = false;
          };

          width = mkOption {
            type = types.int;
            example = 1920;
          };

          height = mkOption {
            type = types.int;
            example = 1080;
          };

          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };

          position = mkOption {
            type = types.str;
            default = "auto";
          };

          scale = mkOption {
            type = types.str;
            default = "1";
          };

          enabled = mkOption {
            type = types.bool;
            default = true;
          };

          workspace = mkOption {
            type = types.nullOr types.str;
            default = null;
          };
        };
      }
    );

    default = [ ];
  };

  config.assertions = [
    {
      assertion =
        ((length cfg.monitors) != 0) -> ((length (filter (monitor: monitor.primary) cfg.monitors)) == 1);
      message = ''
        Exactly one monitor must be set to primary.

        Assign `primary` to a monitor.
      '';
    }
  ];
}
