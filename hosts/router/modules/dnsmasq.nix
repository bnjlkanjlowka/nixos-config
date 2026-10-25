{ ... }:

{
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "ens18";
      bind-interfaces = true;

      dhcp-range = [ "192.168.30.100,192.168.30.199,12h" ];
      dhcp-option = [
        "option:router,192.168.30.1"
        "option:dns-server,192.168.30.112"
        "option:domain-name,spb.lan"
        "option:ntp-server,192.168.30.1"
      ];

      dhcp-host = [
        "9C:6B:00:A0:FD:B2,machine,192.168.30.101,infinite"
        "BC:24:11:20:E6:68,server,192.168.30.112,infinite"
      ];

      host-record = [
        "proxmox.spb.lan,192.168.30.104"
        "machine.spb.lan,192.168.30.101"
        "Pixel-8a.wg,10.0.10.2"

        "server.spb.lan,192.168.30.112"
        "music.bnjlkanjlowka.xyz,192.168.30.112"
        "rss.bnjlkanjlowka.xyz,192.168.30.112"
        "movie.bnjlkanjlowka.xyz,192.168.30.112"
        "vid.bnjlkanjlowka.xyz,192.168.30.112"
        "books.bnjlkanjlowka.xyz,192.168.30.112"
        "contacts.bnjlkanjlowka.xyz,192.168.30.112"
        "bnjlkanjlowka.xyz,192.168.30.112"
      ];

      domain = "spb.lan";
      local = "/spb.lan/";
      domain-needed = true;
      bogus-priv = true;

      no-resolv = true;
      server = [
        "127.0.0.1#5300"
      ];
    };
  };

  networking.firewall.interfaces."ens18" = {
    allowedUDPPorts = [
      53
      67
    ];
    allowedTCPPorts = [ 53 ];
  };

  services.resolved.enable = false;
}
