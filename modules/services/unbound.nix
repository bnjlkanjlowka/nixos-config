{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = "0.0.0.0";
        port = "5353";
        access-control = "192.168.30.0/24 allow";

        tls-upstream = "yes";
        tls-cert-bundle = "/etc/ssl/certs/ca-certificates.crt";
      };

      forward-zone = {
        name = ".";
        forward-tls-upstream = true;
        forward-addr = [
          "1.1.1.1@853"
          "1.0.0.1@853"
        ];
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 5353 ];
    allowedUDPPorts = [ 5353 ];
  };
}
