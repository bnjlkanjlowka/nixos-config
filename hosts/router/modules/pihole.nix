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
            "fd00:30::2 server.spb.lan"

            "192.168.30.112 torrent.spb.lan"
            "fd00:30::2 torrent.spb.lan"

            "192.168.30.1 dns.spb.lan"
            "fd00:30::1 dns.spb.lan"

            "192.168.30.104 proxmox.spb.lan"
            "fd00:30::4 proxmox.spb.lan"

            "fd00:130::20 ru2-server.wg.lan"
            "fd00:130::21 ru1-server.wg.lan"
            "fd00:130::22 gr1-server.wg.lan"
            "fd00:130::23 nl1-server.wg.lan"
            "fd00:130::24 uk1-server.wg.lan"
            "fd00:130::25 usa1-server.wg.lan"
          ];

          piholePTR = "HOSTNAMEFQDN";
          ignoreLocalhost = true;
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
      hostName = "dns.spb.lan";
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
