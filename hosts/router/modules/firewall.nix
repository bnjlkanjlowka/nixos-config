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
        #nginx
        {
          destination = "192.168.30.112:443";
          proto = "tcp";
          sourcePort = 443;
          loopbackIPs = [
            "188.243.72.107"
          ];
        }
        {
          destination = "192.168.30.112:80";
          proto = "tcp";
          sourcePort = 80;
          loopbackIPs = [
            "188.243.72.107"
          ];
        }

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

        #3x-ui
        {
          destination = "192.168.30.112:20053";
          proto = "tcp";
          sourcePort = 20053;
          loopbackIPs = [
            "188.243.72.107"
          ];
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

        #minecraft gtnh server
        {
          destination = "192.168.30.112:14228";
          proto = "tcp";
          sourcePort = 14228;
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
      '';
    };
  };

  networking.nftables.tables.nixos-fw.content = lib.mkBefore ''
    set tcp_ports_server {
      type inet_service
      flags constant
      elements = {
        80, 443, #nginx
        20053, #3x-ui
        51413, #transmission
        1285, #ssh
        14228 #minecraft gtnh server
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
