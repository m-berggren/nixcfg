# App launcher (Super+Space) and dmenu backend for the clipboard picker.
# fuzzel is Wayland-native, tiny, and themed automatically by Stylix.
{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "ghostty -e";
        layer = "overlay";
        width = 45;
      };
    };
  };
}
