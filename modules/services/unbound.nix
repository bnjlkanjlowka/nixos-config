{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = "192.168.30.112";
        port = "5353";
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 5353 ];
    allowedUDPPorts = [ 5353 ];
  };
}
