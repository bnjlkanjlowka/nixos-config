{ config, ... }:

{
  sops = {
    secrets.wg-server-private-key = {
      sopsFile = ../../../secrets/nl1-server/private.key;
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
        "fd00:130::23/128"
      ];
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };
      wireguardConfig = {
        ListenPort = 47893;
        PrivateKeyFile = config.sops.secrets.wg-server-private-key.path;
        RouteTable = "main";
        FirewallMark = 2;
      };

      wireguardPeers = [
        {
          #ru2-server/spb/other vps
          PublicKey = "gjmymkWmv1I77IhdmErAoyQek/sN3GXUlHyyU7uoIh4=";
          AllowedIPs = [
            "fd00:130::/64"
            "fd00:30::/64"
            "fd00:20::/64" #home lan
          ];
          Endpoint = "ru2.ww.bnjlkanjlowka.xyz:47893";
        }
        {
          #usa1-server
          PublicKey = "koGhLm70ivqZX1imR6Vw9pdC/vh/FVHFajdJIkTmbWs=";
          AllowedIPs = [
            "fd00:130::25/128"
          ];
          Endpoint = "usa1.ww.bnjlkanjlowka.xyz:47893";
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 47893 ];

  boot.kernel.sysctl = {
    "net.ipv6.conf.wg0.force_forwarding" = 1;
  };
}
