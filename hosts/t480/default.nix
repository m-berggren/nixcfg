# Host: T480 (ThinkPad). Everything here is true only of this physical machine:
# the hardware scan, hostname, monitor geometry, and hardware-keyed input tuning.
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "t480";

  # Monitor layout (consumed by home/mbx/desktop/hyprland.nix via osConfig.host.*).
  # Identified by serial (desc:) so dock port renaming across reboots is harmless.
  # Home (T-shape):  [HNAY300283] [HNAY200986]
  #                        [eDP-1 centered below]
  host.monitors = [
    "desc:Samsung Electric Company LS24D40xG HNAY300283, 1920x1080@100, 0x0, 1"
    "desc:Samsung Electric Company LS24D40xG HNAY200986, 1920x1080@100, 1920x0, 1"
    "eDP-1, 1920x1080@60, 960x1080, 1"
    # Catch-all for travel / unknown displays.
    ", preferred, auto, 1"
  ];

  # Workspaces pinned to monitors (ignored if a monitor is absent).
  host.workspaces = [
    "1, monitor:eDP-1"
    "2, monitor:eDP-1"
    "3, monitor:eDP-1"
    "4, monitor:desc:Samsung Electric Company LS24D40xG HNAY300283"
    "5, monitor:desc:Samsung Electric Company LS24D40xG HNAY300283"
    "6, monitor:desc:Samsung Electric Company LS24D40xG HNAY300283"
    "7, monitor:desc:Samsung Electric Company LS24D40xG HNAY200986"
    "8, monitor:desc:Samsung Electric Company LS24D40xG HNAY200986"
    "9, monitor:desc:Samsung Electric Company LS24D40xG HNAY200986"
  ];

  # Per-device input tuning, keyed to this laptop's trackpoint and touchpad.
  host.inputDevices = [
    {
      name = "tpps/2-synaptics-trackpoint";
      sensitivity = -0.5;
      accel_profile = "adaptive";
      scroll_factor = 0.3;
    }
    {
      name = "syna801a:00-06cb:cec6-touchpad";
      sensitivity = 1.0;
      accel_profile = "flat";
    }
  ];

  system.stateVersion = "26.05";
}
