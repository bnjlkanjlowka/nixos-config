{ config, ... }:
let
  serverConfig."m.server" = "matrix.bnjlkanjlowka.xyz:443";
  clientConfig."m.homeserver".base_url = "https://matrix.bnjlkanjlowka.xyz";
in
{
  services.postgresql = {
    enable = true;

    ensureUsers = [
      {
        name = "matrix-synapse";
      }
    ];
  };
  services.nginx = {
    enable = true;

    virtualHosts = {
      "bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;
        locations."= /.well-known/matrix/server".extraConfig = ''
          default_type application/json;
          add_header Access-Control-Allow-Origin *;
          return 200 '${builtins.toJSON serverConfig}';
        '';
        locations."= /.well-known/matrix/client".extraConfig = ''
          default_type application/json;
          add_header Access-Control-Allow-Origin *;
          return 200 '${builtins.toJSON clientConfig}';
        '';
      };
      "matrix.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;
        locations."/".extraConfig = ''
          return 404;
        '';
        locations."/_matrix".proxyPass = "http://[::1]:8008";
        locations."/_synapse/client".proxyPass = "http://[::1]:8008";
      };
    };
  };

  sops = {
    secrets.matrix-secret = {
      sopsFile = ../../secrets/matrix/secret.yaml;
      format = "yaml";
      key = "";
    };
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "bnjlkanjlowka.xyz";
      public_baseurl = "https://matrix.bnjlkanjlowka.xyz";
      extraConfigFiles = [ config.sops.secrets.matrix-secret.path ];
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "::1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
      ];
    };
  };
}
