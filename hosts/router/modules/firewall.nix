{ lib, ... }:

{
  networking = {
    nftables.enable = true;

    nat = {
      enable = true;
      externalInterface = "wan0";
      internalInterfaces = [
        "lan0"
        "wg0"
      ];

      forwardPorts = [
        #transmission
        {
          destination = "192.168.30.112:51413";
          proto = "tcp";
          sourcePort = 51413;
        }
        {
          destination = "192.168.30.112:51413";
          proto = "udp";
          sourcePort = 51413;
        }
        #ssh-server
        {
          destination = "192.168.30.112:1285";
          proto = "tcp";
          sourcePort = 1285;
          loopbackIPs = [
            "188.243.72.107"
          ];
        }
      ];
    };

    firewall = {
      enable = true;
      filterForward = true;
      extraForwardRules = ''
        iifname wan0 oifname { lan0, wg0 } ip6 daddr 2a05:3580:fe47:e700::30:2 tcp dport @tcp_ports_server accept
        iifname wan0 oifname { lan0, wg0 } ip6 daddr 2a05:3580:fe47:e700::30:2 udp dport @udp_ports_server accept

        iifname wg0 oifname { lan0, wan0, wg0 } accept comment "allow wireguard to lan, wan, other wg clients"

        iifname lan0 oifname wg0 accept comment "allow lan to wireguard"
      '';
    };
  };

  networking.nftables.tables.nixos-fw.content = lib.mkBefore ''
    set tcp_ports_server {
      type inet_service
      flags constant
      elements = {
        51413, #transmission
        1285, #ssh
      }
    }

    set udp_ports_server {
      type inet_service
      flags constant
      elements = {
        51413 #transmission
      }
    }
  '';
}
