# Status bar. Lean module set (no omarchy custom scripts): workspaces, clock,
# tray, network, audio, cpu, battery. Colors and font come from Stylix.
{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
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
        format = "{id}";
      };

      clock = {
        format = "{:%a %H:%M}";
        format-alt = "{:%Y-%m-%d W%V}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      network = {
        format_icons =  ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-wifi = "{icon}";
        format-ethernet = "󰀂";
        format-disconnected = "󰤮";
        tooltip-format = "{essid} ({frequency} GHz)";
        on-click = "ghostty -e nmtui";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "  muted";
        format-icons.default = [ "" "" "" ];
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        on-click-right = "pavucontrol";
      };

      cpu = {
        format = "  {usage}%";
        interval = 5;
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = "  {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        states = {
          warning = 30;
          critical = 15;
        };
      };

      tray.spacing = 10;
    };
  };
}
