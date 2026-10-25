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
            "true,192.168.20.0/24,192.168.20.115,home.lan"
            "true,10.0.10.0/24,192.168.30.1,wg"
          ];
          listeningMode = "ALL";

          hosts = [
            "192.168.30.112 server.spb.lan"
            "192.168.30.112 torrent.spb.lan"
            "192.168.30.112 music.bnjlkanjlowka.xyz"
            "192.168.30.112 rss.bnjlkanjlowka.xyz"
            "192.168.30.112 movie.bnjlkanjlowka.xyz"
            "192.168.30.112 vid.bnjlkanjlowka.xyz"
            "192.168.30.112 books.bnjlkanjlowka.xyz"
            "192.168.30.112 contacts.bnjlkanjlowka.xyz"
            "192.168.30.112 bnjlkanjlowka.xyz"

            "192.168.30.1 router.spb.lan"

            "192.168.30.104 proxmox.spb.lan"

            "192.168.30.101 machine.spb.lan"
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
