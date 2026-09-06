{ config, ... }:

{
  sops = {
    secrets.miniflux-password = {
      sopsFile = ../../secrets/miniflux/password.env;
      format = "dotenv";
    };
  };

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.sops.secrets.miniflux-password.path;
    config = {
      LISTEN_ADDR = "127.0.0.1:8081";
    };
  };
}
