{ config, ... }:

{
  sops = {
    secrets.kavita-token = {
      sopsFile = ../../../secrets/kavita/token;
      format = "binary";
    };
  };

  services.kavita = {
    enable = true;
    credentials.token_key = config.sops.secrets.kavita-token.path;
    settings = {
      TokenKey = "@token_key@";
      IpAddresses = "fd00:30::2";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];
}
