# System-wide theming via Stylix (replaces Omarchy's theme switcher). One base16
# scheme themes Hyprland borders, waybar, terminals, mako, GTK, and neovim. Because
# home-manager is integrated, this propagates to the user environment automatically.
# Switch themes by changing base16Scheme and rebuilding.
{ pkgs, ... }:

{
  stylix = {
    enable = true;
    polarity = "dark";

    # Browse schemes: ls ${pkgs.base16-schemes}/share/themes
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    # Wallpaper (Stylix requires an image; this also drives the lock/blur background).
    # Ships in nixpkgs, so no hash to maintain. Drop in your own with `image = ./wall.png;`.
    image = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        terminal = 9; # matches the dotfiles' terminal font size
        desktop = 10;
        popups = 11;
      };
    };
  };
}
