# Typed options describing host-specific desktop facts. Set per host (hosts/<name>/),
# consumed by the per-user Hyprland config via osConfig.host.*. This keeps hardware
# truth (which monitors, which input devices) out of portable user config.
{ lib, ... }:

{
  options.host = {
    monitors = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ", preferred, auto, 1" ];
      description = "Hyprland monitor= lines for this host.";
    };

    workspaces = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Hyprland workspace= lines binding workspaces to this host's monitors.";
    };

    inputDevices = lib.mkOption {
      type = with lib.types; listOf attrs;
      default = [ ];
      description = "Hyprland per-device input blocks (device = [ ... ]) keyed to this host's hardware.";
    };
  };
}
