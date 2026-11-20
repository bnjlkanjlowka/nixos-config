{ ... }:

{
  services.rsshub = {
    enable = true;
    settings.LISTEN_INADDR_ANY = true;
  };

  networking.firewall.allowedTCPPorts = [ 1200 ];
}
