# Hyprland, expressed natively in Nix. Monitor/workspace/device data comes from the
# host (osConfig.host.*); everything else here is user preference. No omarchy-* helpers:
# launching is fuzzel, browser is Zen, media/brightness use wpctl/brightnessctl,
# screenshots use grimblast. Border colors and cursor come from Stylix.
{ lib, osConfig, ... }:

let
  terminal = "ghostty";
  # Workspace switch + move-to-workspace for 1..10 (10 bound to the "0" key).
  workspaceBinds = lib.concatLists (
    lib.genList (
      i:
      let
        ws = toString (i + 1);
        key = if i == 9 then "0" else toString (i + 1);
      in
      [
        "$mod, ${key}, workspace, ${ws}"
        "$mod SHIFT, ${key}, movetoworkspace, ${ws}"
      ]
    ) 10
  );
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # Emit the classic hyprland.conf (hyprlang). On stateVersion >= 26.05 the module
    # now defaults to a Lua config (hyprland.lua), which does not support the $mod /
    # bind-string syntax this config uses.
    configType = "hyprlang";
    # home-manager manages the systemd user session: this starts hyprland-session.target
    # / graphical-session.target, which the bar and all desktop services bind to.
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = terminal;
      "$browser" = "zen";
      "$fileManager" = "nautilus --new-window";
      "$editor" = "ghostty -e nvim";
      "$menu" = "fuzzel";

      # Host-provided hardware facts.
      monitor = osConfig.host.monitors;
      workspace = osConfig.host.workspaces;
      device = osConfig.host.inputDevices;

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
      };

      decoration = {
        rounding = 6;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
        };
      };

      dwindle = {
        preserve_split = true;
      };

      # Snappy animations. Durations are in deciseconds (1 = 100ms); defaults feel
      # sluggish, especially the workspace slide. Set animations.enabled = false for
      # instant/no animation.
      animations = {
        enabled = true;
        bezier = [ "snappy, 0.2, 1.0, 0.3, 1.0" ];
        animation = [
          "windows, 1, 2, snappy"
          "windowsOut, 1, 2, snappy"
          "fade, 1, 2, snappy"
          "workspaces, 1, 2, snappy, slide"
          "specialWorkspace, 1, 2, snappy, slidevert"
        ];
      };

      input = {
        kb_layout = "us,se";
        kb_options = "grp:alts_toggle";
        repeat_rate = 40;
        repeat_delay = 600;
        follow_mouse = 1;
        sensitivity = 0.4;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.4;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
      };

      bind =
        [
          # Apps
          "$mod, RETURN, exec, $terminal"
          "$mod SHIFT, RETURN, exec, $browser"
          "$mod SHIFT, B, exec, $browser"
          "$mod SHIFT, F, exec, $fileManager"
          "$mod SHIFT, N, exec, $editor"
          "$mod SHIFT, T, exec, ghostty -e btop"
          "$mod SHIFT, M, exec, spotify"
          "$mod SHIFT, L, exec, logseq"
          "$mod SHIFT, slash, exec, bitwarden"

          # Launcher / menus
          "$mod, SPACE, exec, $menu"
          "$mod CTRL, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

          # Window management
          "$mod, W, killactive"
          "$mod, T, togglefloating"
          "$mod, F, fullscreen, 0"
          "$mod, J, layoutmsg, togglesplit"
          "$mod, P, pseudo"
          "$mod, G, togglegroup"

          # Focus
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "ALT, Tab, cyclenext"
          "ALT SHIFT, Tab, cyclenext, prev"

          # Move window
          "$mod SHIFT, left, swapwindow, l"
          "$mod SHIFT, right, swapwindow, r"
          "$mod SHIFT, up, swapwindow, u"
          "$mod SHIFT, down, swapwindow, d"

          # Resize
          "$mod, minus, resizeactive, -100 0"
          "$mod, equal, resizeactive, 100 0"
          "$mod SHIFT, minus, resizeactive, 0 -100"
          "$mod SHIFT, equal, resizeactive, 0 100"

          # Move window across monitors
          "$mod SHIFT ALT, left, movecurrentworkspacetomonitor, l"
          "$mod SHIFT ALT, right, movecurrentworkspacetomonitor, r"

          # Scratchpad
          "$mod, S, togglespecialworkspace, scratchpad"
          "$mod ALT, S, movetoworkspacesilent, special:scratchpad"

          # Workspace cycling
          "$mod, Tab, workspace, e+1"
          "$mod SHIFT, Tab, workspace, e-1"

          # Screenshots / color picker
          ", PRINT, exec, grimblast --notify copy area"
          "SHIFT, PRINT, exec, grimblast --notify save area"
          "$mod, PRINT, exec, pkill hyprpicker || hyprpicker -a"

          # Session
          "$mod, ESCAPE, exec, loginctl lock-session"
          "$mod SHIFT, ESCAPE, exit"
        ]
        ++ workspaceBinds;

      # Mouse-wheel workspace switching.
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      # Repeat + work while locked: volume and brightness.
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      # Media keys (work while locked, no repeat).
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };
}
