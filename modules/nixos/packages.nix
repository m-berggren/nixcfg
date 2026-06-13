# System-level packages: things that make sense globally rather than per-user.
# Most user-facing apps live in home/mbx/packages.nix instead.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors / base CLI available even as root / in recovery.
    vim
    git
    wget
    curl

    # Wayland session helpers used by Hyprland keybindings (system-wide so they
    # resolve regardless of the user environment).
    brightnessctl
    playerctl
    wl-clipboard
    grim
    slurp
  ];

  # Toolchains that benefit from being on PATH globally.
  programs.nix-ld.enable = true; # let mise-installed dynamic binaries find a loader
}
