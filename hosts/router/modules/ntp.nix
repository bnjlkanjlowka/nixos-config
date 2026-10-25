{ ... }:

{
  services.chrony = {
    enable = true;
    extraConfig = ''
      allow 192.168.30.0/24
    '';

    servers = [
      "0.europe.pool.ntp.org"
      "1.europe.pool.ntp.org"
      "2.europe.pool.ntp.org"
      "3.europe.pool.ntp.org"
    ];
  };

  networking.firewall.interfaces."ens18" = {
    allowedUDPPorts = [ 123 ];
  };
}
