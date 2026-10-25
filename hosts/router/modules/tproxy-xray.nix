{ config, pkgs, ... }:

{
  networking.firewall.extraInputRules = ''
    iifname { "ens18", "wg0" } meta mark 1 accept
  '';

  networking.firewall.interfaces."ens18" = {
    allowedTCPPorts = [ 1090 ];
    allowedUDPPorts = [ 1090 ];
  };

  networking.nftables = {
    #https://prince213.top/blog/2026/01/05/tproxy/
    tables = {
      tproxy-xray = {
        family = "inet";
        content = ''
          chain output {
            type route hook output priority mangle; policy accept;

            meta mark 2 accept;

            meta l4proto { tcp, udp } oifname ens19 meta mark set 1 accept;
          }

          chain prerouting {
            type filter hook prerouting priority mangle; policy accept;

            ct direction reply accept;

            meta l4proto { tcp, udp } fib daddr oifname ens19 iifname { ens18, wg0 } meta mark set 1 tproxy to :12345 accept;

            meta l4proto { tcp, udp } meta mark 1 tproxy to :12345 accept;
          }
        '';
      };
    };
  };

  systemd.network.networks."10-lo" = {
    name = "lo";
    routingPolicyRules = [
      {
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
    "net.ipv4.conf.ens18.rp_filter" = 0;
    "net.ipv4.conf.ens19.rp_filter" = 0;
  };

  networking.firewall.checkReversePath = false;
}
