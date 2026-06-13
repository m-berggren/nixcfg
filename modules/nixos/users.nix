{ pkgs, ... }:

{
  # Fish is the login shell; enabling it here installs system completions and
  # registers it in /etc/shells.
  programs.fish.enable = true;

  users.users.mbx = {
    isNormalUser = true;
    description = "Marcus Berggren";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "video" # brightnessctl / backlight
      "input" # kanata / input devices
    ];
  };
}
