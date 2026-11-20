{ ... }:

{
  services.transmission = {
    enable = true;
    user = "bnjlka";
    settings = {
      rpc-bind-address = "fd00:30::2";
      rpc-host-whitelist = "torrent*";
      rpc_whitelist = "fd00:30::*,fd00:20::*,fd00:130::*";

      download-dir = "/data";
      incomplete-dir-enabled = false;

      speed-limit-down-enabled = true;
      speed-limit-down = 6000;
      speed-limit-up-enabled = true;
      speed-limit-up = 2000;

      proxy-url = "socks5://localhost:1080";

      port_forwarding_enabled = false;
      bind_address_ipv6 = "2a05:3580:fe47:e700::30:2";
    };

    openPeerPorts = true;
  };

  networking.firewall.allowedTCPPorts = [ 9091 ];
}
