{ ... }:

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
      ];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        51413
        20053
      ];
    };
  };
}
