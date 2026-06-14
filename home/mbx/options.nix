# User-level config knobs referenced across multiple home modules, so they have a
# single source of truth instead of being hardcoded per file.
{ config, lib, ... }:

{
  options.local.terminal = lib.mkOption {
    type = lib.types.str;
    default = "ghostty";
    example = "alacritty";
    description = ''
      Default terminal emulator command. Referenced by Hyprland binds, the waybar
      module click actions, and the launcher. Change it here to switch terminals
      everywhere. Commands that run a program use "''${terminal} -e <cmd>".
    '';
  };

  config.home.sessionVariables.TERMINAL = config.local.terminal;
}
