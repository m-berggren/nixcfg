# Lock screen. Colors and background come from Stylix; this just sets the layout.
{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };
      # Background (image + blur) and colors are supplied by Stylix; use attrset
      # form so these layout settings merge with Stylix's color definitions.
      input-field = {
        size = "320, 55";
        position = "0, -80";
        halign = "center";
        valign = "center";
        rounding = 8;
        placeholder_text = "Password";
      };
      label = {
        text = "$TIME";
        font_size = 64;
        position = "0, 120";
        halign = "center";
        valign = "center";
      };
    };
  };
}
