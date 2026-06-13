{ ... }:

{
  networking.networkmanager.enable = true;

  # Mesh VPN (the dotfiles already use tailscale). Authenticate once with `tailscale up`.
  services.tailscale.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
  };
}
