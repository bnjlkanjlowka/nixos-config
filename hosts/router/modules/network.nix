{ ... }:

{
  networking.useDHCP = false;

  systemd.network.links = {
    "10-wan0" = {
      matchConfig.MACAddress = "BC:24:11:FB:E6:A9";
      linkConfig.Name = "wan0";
    };

    "10-lan0" = {
      matchConfig.MACAddress = "BC:24:11:FD:70:15";
      linkConfig.Name = "lan0";
    };
  };

  networking.interfaces = {
    wan0 = {
      useDHCP = true;
      macAddress = "F0:B4:D2:A6:C6:C0";
    };

    lan0 = {
      ipv4.addresses = [
        {
          address = "192.168.30.1";
          prefixLength = 24;
        }
      ];
    };
  };
}
