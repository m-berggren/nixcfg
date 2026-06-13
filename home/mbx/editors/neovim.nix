# Neovim is installed as a plain package; the existing LazyVim setup keeps managing
# plugins at ~/.config/nvim (cloned, not Nix-managed) so lazy-lock.json stays the
# source of truth. We only ensure the runtime/build deps LazyVim expects are present.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    # LSP/build helpers commonly pulled by LazyVim extras
    nixd # Nix LSP
    lua-language-server
    stylua
    nodejs # some LSPs/formatters shell out to node (mise also provides one per-project)
  ];

  home.sessionVariables.EDITOR = "nvim";
}
