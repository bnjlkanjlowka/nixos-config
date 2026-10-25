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
