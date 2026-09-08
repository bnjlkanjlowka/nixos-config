{ ... }:

{
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/etc/radicale/users";
        htpasswd_encryption = "bcrypt";
      };
    };
  };

  services.nginx = {
    virtualHosts."contacts.bnjlkanjlowka.xyz" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:5232";
        extraConfig = ''
          proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header  X-Forwarded-Host $host;
          proxy_set_header  X-Forwarded-Port $server_port;
          proxy_set_header  X-Forwarded-Proto $scheme;
          proxy_set_header  Host $host;
          proxy_pass_header Authorization;
        '';
      };
    };
  };
}
