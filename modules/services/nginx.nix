{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "dolwans12@gmail.com";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "music.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:4533";
        };
      };

      "vid.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:2283";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_read_timeout   600s;
            proxy_send_timeout   600s;
            send_timeout         600s;
          '';
        };
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };
}
