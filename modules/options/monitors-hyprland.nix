{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.modules.monitors = mkOption {
    type = types.listOf (
      types.submodule {
        options.hyprland = mkOption {
          type = types.submodule {
            options = {
              workspace = mkOption {
                type = types.nullOr types.str;
                default = null;
                example = "1";

                description = ''
                  Default workspace to assign to this monitor.

                  Maps to Hyprland's workspace assignment for monitors.
                '';
              };

              vrr = mkOption {
                type = types.enum [
                  0
                  1
                  2
                  3
                ];

                default = 0;

                description = ''
                  Variable Refresh Rate (VRR) setting.

                  - 0: Off
                  - 1: On
                  - 2: Fullscreen only
                  - 3: Fullscreen with `video` or `game` content type
                '';
              };

              rotate = mkOption {
                type = types.enum [
                  0
                  1
                  2
                  3
                  4
                  5
                  6
                  7
                ];

                default = 0;

                description = ''
                  Monitor rotation.

                  - 0: Normal (no transform)
                  - 1: 90° clockwise
                  - 2: 180°
                  - 3: 270° clockwise (90° counter-clockwise)
                  - 4: Flipped
                  - 5: Flipped + 90° clockwise
                  - 6: Flipped + 180°
                  - 7: Flipped + 270° clockwise (90° counter-clockwise)
                '';
              };

              mirror = mkOption {
                type = types.nullOr types.str;
                default = null;
                example = "eDP-1";
                description = "Mirror the specified monitor to this monitor";
              };
            };
          };

          default = { };
          description = "Hyprland-specific monitor options";
        };
      }
    );
  };
}
