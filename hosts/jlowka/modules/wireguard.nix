{ config, ... }:

{
  sops = {
    secrets.wg-peer-private-key = {
      sopsFile = ../../../secrets/wireguard/peer.env;
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
          autoconnect = true;
        };

        wireguard = {
          private-key = "$WG_PRIVATE_KEY";
        };

        ipv4 = {
          method = "manual";
          addresses = "10.0.10.2/32";
          dns = "192.168.30.1";
        };

        ipv6 = {
          method = "manual";
          address1 = "2a05:3580:fe47:e701::2/128";
          address2 = "fd00:130::2/128";
          dns = "fd00:30::1";
        };
        #spb
        "wireguard-peer.4+TpdRwQgNlMiS5lddRHrpMX9VAVzP2zmgLbVCC5LFc=" = {
          endpoint = "188.243.72.107:48783";
          allowed-ips = "0.0.0.0/0;::/0";
        };
      };
    };
  };
}
