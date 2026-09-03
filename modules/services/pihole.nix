{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
    };
    pihole-web = {
      enable = true;
      ports = [ "8080" ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      53
      8080
    ];
    allowedUDPPorts = [ 53 ];
  };
}
