# CLI tools that ship a home-manager program module (for config + shell hooks +
# Stylix theming). Plain binaries with no config live in ../packages.nix.
{ ... }:

{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      inline_height = 15;
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.btop.enable = true;

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  # mise stays the per-project language version manager (imperative installs).
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    globalConfig = {
      tools = {
        node = "latest";
        pnpm = "latest";
        python = "latest";
        zig = "latest";
        dotnet = "latest";
        usage = "latest";
      };
      settings.idiomatic_version_file_enable_tools = [ "ruby" ];
    };
  };
}
