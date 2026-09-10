{ ... }:

{
  services.transmission = {
    enable = true;
    user = "bnjlka";
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,192.168.*.*,10.0.10.*";
      rpc-host-whitelist = "server*";

      download-dir = "/data";
      incomplete-dir-enabled = false;

      speed-limit-down-enabled = true;
      speed-limit-down = 6000;
      speed-limit-up-enabled = true;
      speed-limit-up = 1000;

      proxy-url = "socks5://localhost:1080";
    };

    openRPCPort = true;
    openPeerPorts = true;
  };
}
