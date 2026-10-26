{ config, pkgs, ... }:

{
  networking.firewall.extraInputRules = ''
    iifname { "lan0", "wg0" } meta mark 1 accept
  '';

  networking.firewall.interfaces."lan0" = {
    allowedTCPPorts = [ 1090 ];
    allowedUDPPorts = [ 1090 ];
  };

  networking.nftables = {
    #https://prince213.top/blog/2026/01/05/tproxy/
    tables = {
      tproxy-xray = {
        family = "inet";
        content = ''
          set ip_for_tproxy {
            type ipv4_addr
            flags interval
            elements = {
              #fakedns ip
              198.18.0.0/15,
              #telegram ip
              91.108.56.0/22,
              91.108.4.0/22,
              91.108.8.0/22,
              91.108.16.0/22,
              91.108.12.0/22,
              149.154.160.0/20,
              91.105.192.0/23,
              91.108.20.0/22,
              185.76.151.0/24
            }
          }

          set ipv6_for_tproxy {
            type ipv6_addr
            flags interval
            elements = {
              #fakedns ip
              2001:2::/48
            }
          }

          chain output {
            type route hook output priority mangle; policy accept;

            meta mark 2 accept;

            meta l4proto { tcp, udp } ip daddr @ip_for_tproxy oifname wan0 meta mark set 1 accept;
            meta l4proto { tcp, udp } ip6 daddr @ipv6_for_tproxy oifname wan0 meta mark set 1 accept;
          }

          chain prerouting {
            type filter hook prerouting priority mangle; policy accept;

            ct direction reply accept;

            meta l4proto { tcp, udp } fib daddr oifname wan0 iifname { lan0, wg0 } ip daddr @ip_for_tproxy meta mark set 1 tproxy ip to :12345 accept;
            meta l4proto { tcp, udp } fib daddr oifname wan0 iifname { lan0, wg0 } ip6 daddr @ipv6_for_tproxy meta mark set 1 tproxy ip6 to :12345 accept;

            meta l4proto { tcp, udp } meta mark 1 tproxy ip to :12345 accept;
            meta l4proto { tcp, udp } meta mark 1 tproxy ip6 to :12345 accept;
          }
        '';
      };
    };
  };

  systemd.network.networks."10-lo" = {
    name = "lo";
    routingPolicyRules = [
      {
        Family = "both";
        FirewallMark = 1;
        Table = 100;
      }
    ];
    routes = [
      {
        Type = "local";
        Destination = "0.0.0.0/0";
        Table = 100;
      }
      {
        Type = "local";
        Destination = "::/0";
        Table = 100;
      }
    ];
  };

  sops = {
    secrets.xray-config-router = {
      sopsFile = ../../../secrets/router/config.json;
      format = "json";
      key = "";
      restartUnits = [ "xray.service" ];
    };
  };

  services.xray = {
    enable = true;
    settingsFile = config.sops.secrets.xray-config-router.path;
  };

  environment.systemPackages = [
    pkgs.v2ray-domain-list-community
  ];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.default.rp_filter" = 0;
    "net.ipv4.conf.lan0.rp_filter" = 0;
    "net.ipv4.conf.wan0.rp_filter" = 0;
  };

  networking.firewall.checkReversePath = false;
}
