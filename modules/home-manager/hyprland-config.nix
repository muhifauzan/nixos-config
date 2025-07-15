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
      # Monitor and workspace config generated from modules.monitors

      "monitor" = orIfEmpty [ ", preferred, auto, auto" ] monitors;
      "workspace" = orIfEmpty [ ] workspaces;

      # Rest of Hyprland config

      "$terminal" = "kitty";
      "$editor" = "zeditor";
      "$webBrowser" = "firefox";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";
      "$ai" = "claude-desktop";
      "$musicPlayer" = "spotify";

      exec-once = [
        "nm-applet &"
        "waybar & hyprpaper &"
        "$editor"
        "$terminal"
        "$webBrowser"
        "$ai"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
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
        mfact = 0.382; # Inverse golden ratio
        # mfact = 0.414; # Silver ratio
        # mfact = 0.45; # More usable sides
        # mfact = 0.5; # Simple 50/50
        # mfact = 0.618; # Golden ratio
        new_status = "slave";
        orientation = "left";
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

      "$mainMod" = "SUPER";

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

      bind = [
        "$mainMod, Q, killactive,"
        "$mainMod CTRL ALT SHIFT, Q, exit,"

        "$mainMod, A, exec, $menu"
        "$mainMod, T, exec, $terminal"
        "$mainMod, D, exec, $editor"
        "$mainMod, I, exec, $ai"
        "$mainMod, B, exec, $webBrowser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, U, exec, $musicPlayer"

        "$mainMod, RETURN, fullscreen, 1"
        "$mainMod SHIFT, RETURN, fullscreen,"
        "$mainMod, F, togglefloating,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        #########################
        # Master layout binds

        "$mainMod, SPACE, layoutmsg, swapwithmaster master"
        "$mainMod ALT, SPACE, layoutmsg, focusmaster master"

        # "$mainMod, SPACE, layoutmsg, orientationleft"
        # "$mainMod, SPACE, layoutmsg, orientationcenter"
        "$mainMod CTRL ALT, ENTER, layoutmsg, orientationcycle left center"

        "$mainMod CTRL ALT, 1, layoutmsg, mfact exact 0.382" # Inverse golden ratio
        "$mainMod CTRL ALT, 2, layoutmsg, mfact exact 0.414" # Silver ratio
        "$mainMod CTRL ALT, 3, layoutmsg, mfact exact 0.45" # More usable sides
        "$mainMod CTRL ALT, 4, layoutmsg, mfact exact 0.5" # Simple 50/50
        "$mainMod CTRL ALT, 5, layoutmsg, mfact exact 0.618" # Golden ratio

        # Master layout binds end
        #########################

        ##########################
        # Dwindle layout binds

        "$mainMod, P, pseudo,"

        "$mainMod, J, layoutmsg, togglesplit"
        "$mainMod, K, layoutmsg, togglesplit"

        # Dwindle layout binds end
        ##########################
      ];

      bindl = [
        ", XF86AudioPlay, exec, playerctl --player=spotify,%any play-pause"
        ", XF86AudioPause, exec, playerctl --player=spotify,%any play-pause"
        ", XF86AudioStop, exec, playerctl --all-players stop"

        ", XF86AudioNext, exec, playerctl --player=spotify,%any next"
        ", XF86AudioPrev, exec, playerctl --player=spotify,%any previous"

        ", XF86AudioForward, exec, playerctl --player=spotify,%any position 10+"
        ", XF86AudioRewind, exec, playerctl --player=spotify,%any position 10-"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume --limit=1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        ", XF86MonBrightnessUp, exec, brightnessctl --exponent=4 --min-value=2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl --exponent=4 --min-value=2 set 5%-"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
