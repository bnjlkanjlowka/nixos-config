{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = "0.0.0.0";
        port = "5353";
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 5353 ];
    allowedUDPPorts = [ 5353 ];
  };
}
