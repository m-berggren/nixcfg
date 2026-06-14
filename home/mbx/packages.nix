# User-facing applications and developer tooling. CLI tools that need shell
# integration (eza, bat, zoxide, atuin, fzf, yazi, mise, starship) are configured
# as home-manager programs in ./shell/ and ./terminals/ instead of listed here.
{ pkgs, inputs, ... }:

let
  zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = with pkgs; [
    # Browser
    zen

    # GUI apps (daily drivers)
    spotify
    bitwarden-desktop
    logseq
    nautilus
    vscode

    # Media (light)
    mpv
    imv

    # CLI tools without dedicated program modules
    ripgrep
    fd
    dust
    tldr
    jq
    gh
    lazygit
    lazydocker
    docker-compose
    tree-sitter
    wl-clipboard
    cliphist

    # Audio control panel (waybar right-click)
    pavucontrol

    # On-screen display for volume/brightness (swayosd-client used in hypr binds)
    swayosd

    # Screenshot / color picker (Hyprland keybindings)
    grimblast
    hyprpicker
    satty

    # Build toolchains (language runtimes come from mise; these are the C/C++ side)
    gcc
    clang-tools
    llvm
    gnumake
    cmake
    pkg-config

    # mise needs git/curl/unzip to fetch and build language runtimes
    unzip

    # --- Optional, uncomment if wanted ---
    # jetbrains-toolbox
    # obs-studio
    # kdePackages.kdenlive
    # libreoffice-fresh
    # texliveSmall
    # steam            # also needs programs.steam.enable at system level
  ];
}
