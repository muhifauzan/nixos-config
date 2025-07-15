{ lib, utils }:

let
  inherit (lib)
    concatStringsSep
    filter
    map
    optional
    ;

  inherit (utils) getEnabledMonitors orIfNull;

  toHyprlandMonitor =
    monitor:
    let
      name = monitor.name;
      resolution = "${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}";
      position = orIfNull monitor.position monitor.hyprland.position;
      scale = toString monitor.scale;
      hyprlandOpts = monitor.hyprland;

      optionalArgs =
        optional (hyprlandOpts.rotate != 0) "transform, ${toString hyprlandOpts.rotate}"
        ++ optional (hyprlandOpts.mirror != null) "mirror, ${hyprlandOpts.mirror}"
        ++ optional (hyprlandOpts.vrr != 0) "vrr, ${toString hyprlandOpts.vrr}"
        ++ optional (hyprlandOpts.colour != "auto") "cm, ${toString hyprlandOpts.colour}";

      extraArgs = concatStringsSep ", " optionalArgs;
    in
    concatStringsSep ", " [
      name
      resolution
      position
      scale
      extraArgs
    ];

  getWorkspaceAssignments =
    monitors:
    map (m: "name:${m.hyprland.workspace}, monitor:${m.name}") (
      filter (m: m.hyprland.workspace != null) monitors
    );
in
{
  inherit getEnabledMonitors getWorkspaceAssignments toHyprlandMonitor;
}
