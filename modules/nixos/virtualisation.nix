{ ... }:

{
  # Docker is the daily driver (lazydocker, compose). The mbx user is in the
  # "docker" group (see users.nix).
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
