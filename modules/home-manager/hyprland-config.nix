{ osConfig, libs, ... }:

let
  inherit (libs.utils) orIfEmpty;
  inherit (libs.hyprland.utils) getEnabledMonitors getWorkspaceAssignments toHyprlandMonitor;

  cfg = osConfig.modules;

  enabledMonitors = getEnabledMonitors cfg.monitors;
  monitors = map toHyprlandMonitor enabledMonitors;
  workspaces = getWorkspaceAssignments enabledMonitors;
in
{
  config = {
    wayland.windowManager.hyprland.settings = {
      monitor = orIfEmpty [ ", preferred, auto, auto" ] monitors;
      workspace = orIfEmpty [ ] workspaces;

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      "$menu" = "rofi -show drun";
      "$fileManager" = "dolphin";
      "$terminal" = "kitty";
      "$editor" = "zeditor";
      "$ai" = "claude-desktop";
      "$webBrowser" = "firefox";
      "$musicPlayer" = "spotify";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "nm-applet &"
        "waybar &"
        "hyprpaper &"
        "$editor"
        "$terminal"
        "$ai"
        "$webBrowser"
        "$musicPlayer"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      master = {
        mfact = 0.5;
        new_status = "slave";
        orientation = "center";
        slave_count_for_center_master = 2;
        center_master_fallback = "left";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = false;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Bind flags
      # c -> click, will trigger on release of a key or button as long as the mouse cursor stays inside binds:drag_threshold.
      # d -> has description, will allow you to write a description for your bind.
      # e -> repeat, will repeat when held.
      # g -> drag, will trigger on release of a key or button as long as the mouse cursor moves outside binds:drag_threshold.
      # i -> ignore mods, will ignore modifiers.
      # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
      # m -> mouse, see below.
      # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
      # o -> longPress, will trigger on long press of a key.
      # p -> bypasses the app's requests to inhibit keybinds.
      # r -> release, will trigger on release of a key.
      # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
      # t -> transparent, cannot be shadowed by other binds.

      "$mod" = "SUPER";
      "$mainMod" = "$mod";
      "$ctrlMod" = "$mod CTRL";
      "$altMod" = "$mod ALT";
      "$shiftMod" = "$mod SHIFT";
      "$altCtrlMod" = "$ctrlMod ALT";
      "$shiftCtrlMod" = "$ctrlMod SHIFT";
      "$shiftAltMod" = "$altMod SHIFT";
      "$hyperMod" = "$mod CTRL ALT SHIFT";

      bind = [
        "$hyperMod, Q, exit,"

        "$mainMod, W, killactive,"
        "$mainMod, Q, forcekillactive,"

        "$mainMod, A, exec, $menu"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, T, exec, $terminal"
        "$mainMod, D, exec, $editor"
        "$mainMod, I, exec, $ai"
        "$mainMod, B, exec, $webBrowser"
        "$mainMod, U, exec, $musicPlayer"

        "$mainMod, RETURN, fullscreen, 1"
        "$altMod, RETURN, fullscreen, 0"

        "$mainMod, F, togglefloating, active"

        "$mainMod, left, movefocus, l"
        "$mainMod, down, movefocus, d"
        "$mainMod, up, movefocus, u"
        "$mainMod, right, movefocus, r"

        # Switch workspaces with mainMod + [0-9]
        "$shiftAltMod, 1, workspace, 1"
        "$shiftAltMod, 2, workspace, 2"
        "$shiftAltMod, 3, workspace, 3"
        "$shiftAltMod, 4, workspace, 4"
        "$shiftAltMod, 5, workspace, 5"
        "$shiftAltMod, 6, workspace, 6"
        "$shiftAltMod, 7, workspace, 7"
        "$shiftAltMod, 8, workspace, 8"
        "$shiftAltMod, 9, workspace, 9"
        "$shiftAltMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        # "$shiftCtrlMod, 1, movetoworkspace, 1"
        # "$shiftCtrlMod, 2, movetoworkspace, 2"
        # "$shiftCtrlMod, 3, movetoworkspace, 3"
        # "$shiftCtrlMod, 4, movetoworkspace, 4"
        # "$shiftCtrlMod, 5, movetoworkspace, 5"
        # "$shiftCtrlMod, 6, movetoworkspace, 6"
        # "$shiftCtrlMod, 7, movetoworkspace, 7"
        # "$shiftCtrlMod, 8, movetoworkspace, 8"
        # "$shiftCtrlMod, 9, movetoworkspace, 9"
        # "$shiftCtrlMod, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, terminal"
        # "$shiftCtrlMod, S, movetoworkspace, special:terminal"

        # Scroll through existing workspaces with mainMod + scroll
        # "$mainMod, mouse_down, workspace, e+1"
        # "$mainMod, mouse_up, workspace, e-1"

        #########################
        # Master layout binds

        "$ctrlMod, RETURN, layoutmsg, focusmaster master"

        "$shiftMod, RETURN, layoutmsg, swapwithmaster master"

        "$altMod, H, layoutmsg, orientationleft"
        "$altMod, J, layoutmsg, orientationcenter"
        "$altMod, SPACE, layoutmsg, orientationcycle left center"

        "$altMod, 1, layoutmsg, mfact exact 0.382" # Inverse golden ratio
        "$altMod, 2, layoutmsg, mfact exact 0.414" # Silver ratio
        "$altMod, 3, layoutmsg, mfact exact 0.45" # More usable sides
        "$altMod, 4, layoutmsg, mfact exact 0.5" # Simple 50/50
        "$altMod, 5, layoutmsg, mfact exact 0.618" # Golden ratio

        # Master layout binds end
        #########################

        ##########################
        # Dwindle layout binds

        "$mainMod, P, pseudo,"

        "$altMod, J, layoutmsg, togglesplit"
        "$altMod, K, layoutmsg, togglesplit"

        # Dwindle layout binds end
        ##########################
      ];

      bindl = [
        ", XF86AudioPlay, exec, playerctl --player=spotify,%any play-pause"
        ", XF86AudioPause, exec, playerctl --player=spotify,%any play-pause"
        ", XF86AudioStop, exec, playerctl --all-players stop"

        ", XF86AudioNext, exec, playerctl --player=spotify,%any next"
        ", XF86AudioPrev, exec, playerctl --player=spotify,%any previous"

        ", XF86AudioForward, exec, playerctl --player=spotify,%any position 5+"
        ", XF86AudioRewind, exec, playerctl --player=spotify,%any position 5-"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume --limit=1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl --min-value=3 set 5%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
