{ ... }:

{
  services.kavita = {
    enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 5000 ];
    allowedUDPPorts = [ 5000 ];
  };
}
