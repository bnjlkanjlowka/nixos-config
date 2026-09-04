{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
        dns = {
          upstreams = [ "192.168.30.1#53" ];
          revServers = [
            "true,192.168.30.0/24,192.168.30.1,spb.lan"
            "true,192.168.20.0/24,192.168.20.1,home.lan"
          ];
        };
      };

      lists = [
        {
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/ultimate.txt";
          type = "block";
          enabled = true;
          description = "hagezi blocklist ultimate";
        }

        {
          url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/tif.txt";
          type = "block";
          enabled = true;
          description = "hagezi blocklist threat feeds";
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
