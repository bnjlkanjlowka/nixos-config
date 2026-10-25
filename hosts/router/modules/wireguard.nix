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
        FirewallMark = 2;
      };

      wireguardPeers = [
        {
          #Pixel-8a
          PublicKey = "Cuy/BjsTUEaSui2JKqdRuJzkS5K1MrRKH+sTzwtsixs=";
          AllowedIPs = [
            "10.0.10.2/32"
          ];
        }
        {
          #home
          PublicKey = "RhjVjUmN9ZMk+FciEOzLbMTNFhgs4WVEA2YI+pXOjHY=";
          AllowedIPs = [
            "192.168.10.0/24"
            "192.168.20.0/24"
            "10.0.10.1/32"
          ];
          Endpoint = "79.111.156.73:49833";
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 48783 ];
}
