# nixcfg

NixOS configuration for a lean, Omarchy-inspired Hyprland desktop. Authored on an
Arch machine, deployed to the ThinkpPad **T480** (NixOS unstable).

## Layout

```
flake.nix              inputs (nixpkgs, home-manager, stylix, zen-browser) + nixosConfigurations.t480
hosts/t480/            this machine: hardware scan, hostname, monitor/workspace/input data
modules/nixos/         general OS config, reusable on any host (one file per concern)
home/mbx/              user environment: shell, hyprland, waybar, terminals, apps, neovim
```

The split is strict: **host** = facts about this physical machine, **modules** =
host-agnostic OS config, **home** = user preferences. Monitor geometry is host data
(`host.monitors`/`host.workspaces` in `hosts/t480/default.nix`) consumed by the
per-user Hyprland config through `osConfig`, so personal config stays portable.

## Validate from anywhere (no activation)

```fish
nix flake check
nix build .#nixosConfigurations.t480.config.system.build.toplevel
```

## Deploy to the T480

Push this repo to GitHub, then on the box:

```fish
sudo nixos-rebuild boot --flake github:m-berggren/nixcfg#t480   # first cutover: 'boot' so a bad
                                                                # session can be rolled back
sudo nixos-rebuild switch --flake github:m-berggren/nixcfg#t480 # thereafter
```

Or push the build straight from the Arch box over SSH:

```fish
nixos-rebuild switch --flake .#t480 \
  --target-host t480-nixos --build-host t480-nixos --use-remote-sudo
```

Rollback: pick the previous generation in the systemd-boot menu, or
`sudo nixos-rebuild switch --rollback`.

## Notes

- **Theme**: change `base16Scheme` in `modules/nixos/theme.nix` and rebuild. Browse
  options with `ls $(nix eval --raw nixpkgs#base16-schemes)/share/themes`.
- **Languages**: `mise` manages per-project runtimes (node, python, zig, dotnet, pnpm).
- **Neovim**: plugins stay managed by the existing LazyVim repo at `~/.config/nvim`.
- **Secrets**: `~/.config/fish/secrets.fish` and `~/.config/git/config-chalmers` are
  kept locally and are not part of this repo.
- First login uses greetd; pick the "Hyprland" session.
```
