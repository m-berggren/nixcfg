# Aggregates the general (host-agnostic) NixOS modules. Any host imports this set.
{ ... }:

{
  imports = [
    ./host-options.nix
    ./boot.nix
    ./nix-settings.nix
    ./locale.nix
    ./networking.nix
    ./audio.nix
    ./desktop.nix
    ./theme.nix
    ./virtualisation.nix
    ./kanata.nix
    ./users.nix
    ./packages.nix
  ];
}
