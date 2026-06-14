# Background desktop services, declared as home-manager modules (which create
# systemd user units) instead of a pile of Hyprland exec-once lines. Replaces
# Omarchy's autostart chain. All themed by Stylix where applicable.
{ pkgs, lib, ... }:

{
  # Notifications.
  services.mako.enable = true;

  # Wallpaper (driven by Stylix's image).
  services.hyprpaper.enable = true;

  # Idle handling: dim/lock after inactivity, suspend later.
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150; # 2.5 min: screen off
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 300; # 5 min: lock
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600; # 10 min: suspend
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # Clipboard history daemon (consumed by the Super+Ctrl+V fuzzel picker).
  systemd.user.services.cliphist = {
    Unit = {
      description = "Clipboard history daemon";
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };
  };

  # On-screen-display server for volume/brightness/caps popups. The keybinds in
  # hyprland.nix call swayosd-client, which performs the change and shows the OSD.
  systemd.user.services.swayosd = {
    Unit = {
      description = "swayosd on-screen display server";
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
    };
  };

  # Polkit authentication agent (GUI privilege prompts).
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      description = "Hyprland polkit authentication agent";
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
  };
}
