{ config, ... }:

{
  sops = {
    secrets.miniflux-password = {
      sopsFile = ../../../secrets/miniflux/password.env;
      format = "dotenv";
    };
  };

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.sops.secrets.miniflux-password.path;
    config = {
      LISTEN_ADDR = "[fd00:30::2]:8081";
      FETCHER_ALLOW_PRIVATE_NETWORKS = 1;
    };
  };

  networking.firewall.allowedTCPPorts = [ 8081 ];
}
