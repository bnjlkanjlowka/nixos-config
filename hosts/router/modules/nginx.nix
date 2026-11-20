{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "dolwans12@gmail.com";
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
  };

  services.nginx = {
    enable = true;

    virtualHosts = {
      "vid.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://server.spb.lan:2283";
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

      "movie.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;
        extraConfig = ''
          client_max_body_size 20M;
          add_header X-Content-Type-Options "nosniff";
          add_header Permissions-Policy "accelerometer=(), ambient-light-sensor=(), battery=(), bluetooth=(), camera=(), clipboard-read=(), display-capture=(), document-domain=(), encrypted-media=(), gamepad=(), geolocation=(), gyroscope=(), hid=(), idle-detection=(), interest-cohort=(), keyboard-map=(), local-fonts=(), magnetometer=(), microphone=(), payment=(), publickey-credentials-get=(), serial=(), sync-xhr=(), usb=(), xr-spatial-tracking=()" always;
          add_header Content-Security-Policy "default-src https: data: blob: ; img-src 'self' https://* ; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' https://www.gstatic.com https://www.youtube.com blob:; worker-src 'self' blob:; connect-src 'self'; object-src 'none'; font-src 'self'";
        '';

        locations = {
          "/" = {
            proxyPass = "http://server.spb.lan:8096";
            recommendedProxySettings = true;
            extraConfig = ''
              proxy_buffering off;
            '';
          };

          "/socket" = {
            proxyPass = "http://server.spb.lan:8096";
            proxyWebsockets = true;
            recommendedProxySettings = true;
          };
        };
      };

      "books.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://server.spb.lan:5000";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };

      "rss.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://server.spb.lan:8081";
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_redirect off;
          '';
        };
      };

      "music.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://server.spb.lan:4533";
          recommendedProxySettings = true;
        };
      };

      "contacts.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://server.spb.lan:5232";
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_pass_header Authorization;
          '';
        };
      };

      "rsshub.spb.lan" = {
        extraConfig = ''
          allow 192.168.30.0/24;
          allow fd00:30::/64;

          deny all;
        '';

        locations."/" = {
          proxyPass = "http://server.spb.lan:1200";
          recommendedProxySettings = true;
        };
      };

      "torrent.spb.lan" = {
        serverAliases = [
          "torrent"
        ];
        extraConfig = ''
          allow 192.168.30.0/24;
          allow 192.168.20.0/24;
          allow fd00:30::/64;
          allow fd00:130::/64;
          allow fd00:20::/64;

          deny all;
        '';

        locations."/" = {
          proxyPass = "http://server.spb.lan:9091";
          recommendedProxySettings = true;
        };
      };

      "dns.spb.lan" = {
        serverAliases = [
          "dns"
        ];
        extraConfig = ''
          allow 192.168.30.0/24;
          allow 192.168.20.0/24;
          allow fd00:30::/64;
          allow fd00:130::/64;
          allow fd00:20::/64;

          deny all;
        '';

        locations."/" = {
          proxyPass = "http://[::1]:8080";
          recommendedProxySettings = true;
        };
      };
    };
  };
}
