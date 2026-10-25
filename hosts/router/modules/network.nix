{ ... }:

{
  networking.useDHCP = false;

  networking.interfaces = {
    ens19 = {
      useDHCP = true;
      macAddress = "F0:B4:D2:A6:C6:C0";
    };

    ens18 = {
      ipv4.addresses = [
        {
          address = "192.168.30.1";
          prefixLength = 24;
        }
      ];
    };
  };
}
