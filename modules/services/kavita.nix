{ config, ... }:

{
  sops = {
    secrets.kavita-token = {
      sopsFile = ../../secrets/kavita/token;
      format = "binary";
    };
  };

  services.kavita = {
    enable = true;
    tokenKeyFile = config.sops.secrets.kavita-token;
  };

  networking.firewall = {
    allowedTCPPorts = [ 5000 ];
    allowedUDPPorts = [ 5000 ];
  };
}
