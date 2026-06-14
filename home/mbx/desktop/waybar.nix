# Status bar. Lean module set (no omarchy custom scripts): workspaces, clock,
# tray, network, audio, cpu, battery. Colors and font come from Stylix.
{ config, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    # Appended after Stylix's generated CSS. GTK CSS quirks: border-bottom must carry a
    # color (use transparent, not none) and !important is rejected on the shorthand
    # ("junk at end of value"), and an invalid rule blanks the whole bar. So we beat
    # Stylix's underline by matching its exact selectors (.modules-* #workspaces
    # button.active/.focused) at equal specificity and appending later, which wins.
    # Active workspace is shown by its icon (the Omarchy way). The margins give even
    # horizontal spacing now that built-in spacing is 0 (tweak the 6px to taste).
    style = lib.mkAfter ''
      #workspaces button {
        padding: 0 6px;
      }
      .modules-left #workspaces button.focused,
      .modules-left #workspaces button.active,
      .modules-center #workspaces button.focused,
      .modules-center #workspaces button.active,
      .modules-right #workspaces button.focused,
      .modules-right #workspaces button.active {
        border-bottom: 3px solid transparent;
      }
      #clock,
      #network,
      #pulseaudio,
      #cpu,
      #battery,
      #tray {
        margin: 0 6px;
      }
    '';
    settings.mainBar = {
      spacing = 0;
      layer = "top";
      position = "top";
      height = 26;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "tray"
        "network"
        "pulseaudio"
        "cpu"
        "battery"
      ];

      "hyprland/workspaces" = {
        on-click = "activate";
        format = "{icon}";
        format-icons = {
          default = "";
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "0";
          active = "󱓻";
        };
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
        };
      };

      clock = {
        format = "{:%a %H:%M}";
        format-alt = "{:%Y-%m-%d W%V}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      network = {
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-wifi = "{icon}";
        format-ethernet = "󰀂";
        format-disconnected = "󰤮";
        tooltip-format-wifi = "{essid} ({frequency} GHz)";
        tooltip-format-ethernet = "Connected";
        tooltip-format-disconnected = "Disconnected";
        interval = 3;
        spacing = 1;
        on-click = "${config.local.terminal} -e nmtui";
      };

      pulseaudio = {
        format = "{icon}";
        format-muted = ""    ;
        format-icons = {
          headphone = "";
          headset = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
        on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      cpu = {
        format = "󰍛";
        interval = 5;
        on-click = "${config.local.terminal} -e btop";
      };

      battery = {
        format = "{icon}";
        format-charging = "{icon}";
        format-plugged = "";
        format-icons = {
          charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        format-full = "󰂅";
        states = {
          warning = 30;
          critical = 15;
        };
      };
      tray = {
        icon-size = 12;
        spacing = 12;
      };
    };
  };
}
