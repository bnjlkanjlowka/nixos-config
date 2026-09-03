{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      port = "5353";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 5353 ];
    allowedUDPPorts = [ 5353 ];
  };
}
