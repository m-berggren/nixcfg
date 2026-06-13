{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  # Logseq still ships an old Electron flagged insecure. Bump the version string
  # if a future logseq update changes it (the eval error tells you the new one).
  nixpkgs.config.permittedInsecurePackages = [ "electron-39.8.10" ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "mbx" ];
    auto-optimise-store = true;
  };

  # Keep the store from growing without bound.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
