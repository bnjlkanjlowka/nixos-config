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
      FETCHER_ALLOW_PRIVATE_NETWORKS = 1;
    };
  };

  services.nginx = {
    virtualHosts."rss.bnjlkanjlowka.xyz" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8081";
        extraConfig = ''
          proxy_redirect off;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
