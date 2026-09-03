{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
        dns.interface = [ "192.168.30.112" ];
      };
    };
    pihole-web = {
      enable = true;
      ports = [ "8080" ];
    };
  };
}
