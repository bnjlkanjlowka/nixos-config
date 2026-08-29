{ config, ... }:

{
  sops = {
    secrets.wg-peer-private-key = {
      sopsFile = ../../secrets/wireguard/peer.env;
      format = "dotenv";
    };
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.secrets.wg-peer-private-key.path ];
    profiles = {
      wg = {
        connection = {
          id = "home-wg";
          type = "wireguard";
          interface-name = "wg0";
          autoconnect = false;
        };

        wireguard = {
          private-key = "$WG_PRIVATE_KEY";
        };

        ipv4 = {
          method = "manual";
          addresses = "10.0.10.2/24";
          dns = "192.168.10.115;192.168.20.1";
          dns-search = "~home.lan";
        };

        ipv6 = {
          method = "disabled";
        };

        "wireguard-peer.RhjVjUmN9ZMk+FciEOzLbMTNFhgs4WVEA2YI+pXOjHY=" = {
          endpoint = "79.111.156.73:49833";
          allowed-ips = "192.168.10.0/24;192.168.20.0/24;10.0.10.0/24";
        };
      };
    };
  };
}
