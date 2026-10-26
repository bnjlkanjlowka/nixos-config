{ ... }:

{
  systemd.network = {
    links = {
      "10-wan0" = {
        matchConfig.MACAddress = "BC:24:11:FB:E6:A9";
        linkConfig.Name = "wan0";
      };

      "10-lan0" = {
        matchConfig.MACAddress = "BC:24:11:FD:70:15";
        linkConfig.Name = "lan0";
      };
    };

    networks = {
      "10-wan" = {
        matchConfig.Name = "wan0";
        linkConfig = {
          MACAddress = "F0:B4:D2:A6:C6:C0";
        };
        networkConfig = {
          IPv6AcceptRA = true;
          DHCP = "yes";
        };
      };

      "10-lan0" = {
        matchConfig.Name = "lan0";
        address = [
          "192.168.30.1/24"
        ];

        networkConfig = {
          DHCP = "no";
          IPv6SendRA = true;
          DHCPPrefixDelegation = true;
          IPv6AcceptRA = false;
        };

        dhcpPrefixDelegationConfig = {
          UplinkInterface = "wan0";
          SubnetId = "auto";
          Announce = "yes";
        };
      };
    };
  };
}
