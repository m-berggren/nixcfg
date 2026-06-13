# General desktop stack: Hyprland, the greetd login manager, portals, polkit, and
# system fonts. Per-user Hyprland config lives in home/mbx/desktop/. Session and
# service startup is handled by home-manager's systemd integration (see hyprland.nix),
# not uwsm.
{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  # Minimal login manager. Launch via Hyprland's own session wrapper start-hyprland
  # (shipped in the hyprland package) rather than the raw Hyprland binary: it sets up
  # the systemd/D-Bus session properly and silences Hyprland's "launched without
  # start-hyprland" warning. --cmd avoids depending on wayland-session file discovery.
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
      user = "greeter";
    };
  };

  security.polkit.enable = true;

  # Portals for screen sharing and native file dialogs. The Hyprland portal is
  # pulled in by programs.hyprland; add the GTK portal for file pickers.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # File-manager helpers (nautilus is the bound file manager) and thumbnails.
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      font-awesome
    ];
    fontconfig.defaultFonts = {
      monospace = [ "CaskaydiaMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
