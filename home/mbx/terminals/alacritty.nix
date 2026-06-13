# Alacritty. Font family/size and colors are supplied by Stylix; this sets the
# window/padding/keybinding bits. Shell falls through to the user's login shell (fish).
{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        padding = {
          x = 14;
          y = 14;
        };
        decorations = "None";
      };
      terminal.osc52 = "CopyPaste";
      keyboard.bindings = [
        { key = "F11"; action = "ToggleFullscreen"; }
        { key = "Insert"; mods = "Shift"; action = "Paste"; }
        { key = "Insert"; mods = "Control"; action = "Copy"; }
        { key = "Return"; mods = "Shift"; chars = "\r"; }
      ];
    };
  };
}
