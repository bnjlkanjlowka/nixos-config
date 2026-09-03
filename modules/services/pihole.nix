{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
        dns = {
          upstreams = [ "192.168.30.1#53" ];
        };
      };

      lists = [
        {
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.plus.txt";
          type = "block";
          enabled = true;
          description = "hagezi blocklist pro plus";
        }
      ];
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
