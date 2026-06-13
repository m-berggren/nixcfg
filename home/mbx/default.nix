{ ... }:

{
  imports = [
    ./packages.nix
    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/cli.nix
    ./shell/git.nix
    ./desktop/hyprland.nix
    ./desktop/waybar.nix
    ./desktop/services.nix
    ./desktop/hyprlock.nix
    ./desktop/launcher.nix
    ./terminals/alacritty.nix
    ./terminals/ghostty.nix
    ./editors/neovim.nix
  ];

  home.username = "mbx";
  home.homeDirectory = "/home/mbx";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
