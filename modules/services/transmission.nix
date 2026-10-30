{ ... }:

{
  services.transmission = {
    enable = true;
    user = "bnjlka";
    settings = {
      rpc-host-whitelist = "torrent*";

      download-dir = "/data";
      incomplete-dir-enabled = false;

      speed-limit-down-enabled = true;
      speed-limit-down = 6000;
      speed-limit-up-enabled = true;
      speed-limit-up = 1000;

      proxy-url = "socks5://localhost:1080";

      port_forwarding_enabled = false;
      bind_address_ipv6 = "2a05:3580:fe47:e700::30:2";
    };

    openPeerPorts = true;
  };

  services.nginx = {
    virtualHosts."torrent.spb.lan" = {
      serverAliases = [
        "torrent"
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:9091";
        recommendedProxySettings = true;
      };
    };
  };
}
