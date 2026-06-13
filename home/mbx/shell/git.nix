# Git identity and the Chalmers-scoped override from the dotfiles' .gitconfig.
{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Marcus Berggren";
      user.email = "berggren.me@outlook.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      fetch.prune = true;
    };

    # Chalmers projects use a separate identity (kept in an untracked file).
    includes = [
      {
        condition = "gitdir:~/Documents/projects/gitlab/";
        path = "~/.config/git/config-chalmers";
      }
    ];
  };
}
