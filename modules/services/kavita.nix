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
    tokenKeyFile = config.sops.secrets.kavita-token.path;
  };

  services.nginx = {
    virtualHosts."books.bnjlkanjlowka.xyz" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:5000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header        Host $host;
          proxy_set_header        X-Real-IP $remote_addr;
          proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for; aio threads;
          proxy_set_header        X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
