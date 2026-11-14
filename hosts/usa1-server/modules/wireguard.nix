{ config, ... }:

{
  sops = {
    secrets.wg-server-private-key = {
      sopsFile = ../../../secrets/usa1-server/private.key;
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
        "fd00:130::25/128"
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
          #nl1-server/spb/other vps
          PublicKey = "qNqkfcZ/BbMxP0Se1v6dgJrNVRSdeZ/YdsmqAWzQVQY=";
          AllowedIPs = [
            "fd00:130::/64"
            "fd00:30::/64"
          ];
          Endpoint = "nl1.ww.bnjlkanjlowka.xyz:47893";
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 47893 ];
}
