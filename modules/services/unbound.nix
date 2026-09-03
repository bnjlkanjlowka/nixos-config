{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = "0.0.0.0";
        port = "5353";
        access-control = "192.168.30.0/24 allow";
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 5353 ];
    allowedUDPPorts = [ 5353 ];
  };
}
