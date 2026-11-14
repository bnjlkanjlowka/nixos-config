{ config, ... }:

{
  sops = {
    secrets.wg-server-private-key = {
      sopsFile = ../../../secrets/ru2-server/private.key;
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
        "fd00:130::20/128"
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
          #spb
          PublicKey = "4+TpdRwQgNlMiS5lddRHrpMX9VAVzP2zmgLbVCC5LFc=";
          AllowedIPs = [
            "fd00:130::10/128"
            "fd00:130::2/128" # jlowka
            "fd00:130::3/128" # Pixel-8a
            "fd00:130::1/128" # home
            "fd00:30::10/64"
          ];
          Endpoint = "wg.bnjlkanjlowka.xyz:48783";
        }
        {
          #ru1-server
          PublicKey = "in5EofUo0ITQ9EVMDLDoNMFM498bfP6WLxbDpJyLMh4=";
          AllowedIPs = [
            "fd00:130::21/128"
          ];
          Endpoint = "ru1.ww.bnjlkanjlowka.xyz:47893";
        }
        {
          #gr1-server
          PublicKey = "Yc/hrPy6ZCGPtRKIpRx/Ft2A4f8KDbUKLRH0G+9xamg=";
          AllowedIPs = [
            "fd00:130::22/128"
          ];
          Endpoint = "gr1.ww.bnjlkanjlowka.xyz:47893";
        }
        {
          #nl1-server/usa1-server
          PublicKey = "qNqkfcZ/BbMxP0Se1v6dgJrNVRSdeZ/YdsmqAWzQVQY=";
          AllowedIPs = [
            "fd00:130::23/128"
            "fd00:130::25/128"
          ];
          Endpoint = "nl1.ww.bnjlkanjlowka.xyz:47893";
        }
        {
          #uk1-server
          PublicKey = "okFtIbyQSxQc1VoHsZ15aHNz/QRTbzf5afyijWY/egA=";
          AllowedIPs = [
            "fd00:130::24/128"
          ];
          Endpoint = "uk1.ww.bnjlkanjlowka.xyz:47893";
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = [ 47893 ];

  boot.kernel.sysctl = {
    "net.ipv6.conf.wg0.force_forwarding" = 1;
  };
}
