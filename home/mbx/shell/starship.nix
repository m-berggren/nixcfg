# Starship prompt. The dotfiles carry a large hand-tuned starship.toml; Starship
# auto-detects almost everything, so this enables it with fish integration and a
# couple of sensible defaults. Drop the old toml into ~/.config/starship.toml (or
# port it into programs.starship.settings) if you want the exact previous prompt.
{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
    };
  };
}
