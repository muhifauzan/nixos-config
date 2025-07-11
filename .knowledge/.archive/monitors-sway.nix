# Sway Monitor Extension
{ lib, ... }:

{
  config.modules._monitorExtensions = [
    {
      options.sway = lib.mkOption {
        type = lib.types.submodule {
          options = {
            workspace = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              example = "1";
              description = ''
                Default workspace to assign to this monitor in Sway.

                Can be a workspace number or name.
              '';
            };

            adaptive_sync = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = ''
                Enable adaptive sync (FreeSync/G-Sync) for this monitor in Sway.
              '';
            };

            dpms = lib.mkOption {
              type = lib.types.bool;
              default = true;
              description = ''
                Enable DPMS (Display Power Management Signaling) for this monitor.

                When enabled, the monitor will enter power saving modes
                when not in use.
              '';
            };

            max_render_time = lib.mkOption {
              type = lib.types.nullOr lib.types.ints.positive;
              default = null;
              example = 5;
              description = ''
                Maximum render time in milliseconds for this monitor.

                Can help with VRR displays to reduce input latency.
              '';
            };

            subpixel = lib.mkOption {
              type = lib.types.enum [
                "unknown"
                "none"
                "horizontal_rgb"
                "horizontal_bgr"
                "vertical_rgb"
                "vertical_bgr"
              ];
              default = "unknown";
              description = ''
                Subpixel layout for this monitor.

                Affects text rendering quality on LCD displays.
              '';
            };

            background = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              example = "/path/to/wallpaper.jpg";
              description = ''
                Background image path for this monitor.

                Sets the wallpaper for this specific monitor in Sway.
              '';
            };
          };
        };
        default = { };
        description = ''
          Sway-specific monitor options.

          These options are automatically available when the Sway
          extension is loaded, providing type-safe configuration for
          Sway's output features.
        '';
      };
    }
  ];
}
