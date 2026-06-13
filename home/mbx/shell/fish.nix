# Fish shell. Tool integrations (starship, zoxide, atuin, mise, fzf) are wired up
# by their own home-manager program modules with enableFishIntegration, so they
# are not re-initialised here.
{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      cd = "z"; # zoxide
      ls = "eza -la --color=always --group-directories-first";
    };

    shellInit = ''
      set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
    '';

    interactiveShellInit = ''
      set -g fish_greeting

      # Local, untracked secrets (API tokens, etc.) if present.
      if test -f ~/.config/fish/secrets.fish
        source ~/.config/fish/secrets.fish
      end
    '';
  };

  # A specific dev build of zig lives in ~/.zig (managed outside mise on purpose);
  # pnpm's global bin dir is on PATH too.
  home.sessionVariables.PNPM_HOME = "$HOME/.local/share/pnpm";
  home.sessionPath = [
    "$HOME/.zig"
    "$HOME/.local/share/pnpm"
  ];
}
