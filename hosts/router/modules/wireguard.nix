{ config, ... }:

{
  sops = {
    secrets.wg-server-private-key = {
      sopsFile = ../../../secrets/router/wireguard/private.key;
      format = "binary";
      mode = "0640";
      owner = "systemd-network";
      group = "systemd-network";
    };
  };

  systemd.network = {
    networks."50-wg0" = {
      name = "wg0";
      address = [
        "10.0.10.10/24"
        "fd00:130::10/64"
        "2a05:3580:fe47:e701::10/64"
      ];
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 48783;
        PrivateKeyFile = config.sops.secrets.wg-server-private-key.path;
        RouteTable = "main";
      };

      wireguardPeers = [
        {
          #Pixel-8a
          PublicKey = "Cuy/BjsTUEaSui2JKqdRuJzkS5K1MrRKH+sTzwtsixs=";
          AllowedIPs = [
            "10.0.10.3/32"
            "fd00:130::3/128"
            "2a05:3580:fe47:e701::3/128"
          ];
        }
        {
          #jlowka
          PublicKey = "w9kWiXYWTZNQa3wvOB1CArZlppSk4nPTz93kHj+DCUU=";
          AllowedIPs = [
            "10.0.10.2/32"
            "fd00:130::2/128"
            "2a05:3580:fe47:e701::2/128"
          ];
        }
        {
          #home
          PublicKey = "RhjVjUmN9ZMk+FciEOzLbMTNFhgs4WVEA2YI+pXOjHY=";
          AllowedIPs = [
            "192.168.20.0/24"
            "10.0.10.1/32"
            "fd00:130::1/128"
            "fd00:20::/64"
          ];
          Endpoint = "79.111.156.73:49833";
        }
        {
          #ru2-server/other vps
          PublicKey = "gjmymkWmv1I77IhdmErAoyQek/sN3GXUlHyyU7uoIh4=";
          AllowedIPs = [
            "fd00:130::20/64"
          ];
          Endpoint = "ru2.ww.bnjlkanjlowka.xyz:47893";
          PersistentKeepalive = 30;
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 48783 ];
}
