{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
      settings = {
        dns = {
          upstreams = [ "192.168.30.1#5300" ];
          revServers = [
            "true,192.168.20.0/24,192.168.20.115,home.lan"
          ];
          listeningMode = "ALL";
          domainNeeded = true;
          domain = {
            name = "spb.lan";
          };

          hosts = [
            "192.168.30.112 server.spb.lan"
            "192.168.30.112 torrent.spb.lan"

            "192.168.30.1 dns.spb.lan"
          ];

          piholePTR = "HOSTNAMEFQDN";
        };

        dhcp = {
          active = true;
          start = "192.168.30.100";
          end = "192.168.30.199";
          router = "192.168.30.1";
          netmask = "255.255.255.0";
          hosts = [
            "9C:6B:00:A0:FD:B2,machine,192.168.30.101,infinite"
            "BC:24:11:20:E6:68,server,192.168.30.112,infinite"
          ];
        };

        ntp = {
          ipv4 = {
            active = true;
            address = "0.0.0.0";
          };

          sync = {
            active = true;
            server = "pool.ntp.org";
          };
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

  services.nginx = {
    virtualHosts."dns.spb.lan" = {
      serverAliases = [
        "dns"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        recommendedProxySettings = true;
      };
    };
  };

  networking.firewall.interfaces = {
    "lan0" = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [
        53
        67
      ];
    };
    "wg0" = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  services.resolved.enable = false;
}
