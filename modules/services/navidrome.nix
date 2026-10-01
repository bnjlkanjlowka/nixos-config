{ config, ... }:

{
  sops = {
    secrets.lastfm-keys = {
      sopsFile = ../../secrets/navidrome/lastfm.env;
      format = "dotenv";
    };
  };

  services.navidrome = {
    enable = true;
    environmentFile = config.sops.secrets.lastfm-keys.path;
    settings = {
      MusicFolder = "/data/music";
      Address = "127.0.0.1";
    };
  };

  users.groups.music = {
    gid = 1007;
    members = [
      "bnjlka"
      "navidrome"
    ];
  };

  services.nginx = {
    virtualHosts."music.bnjlkanjlowka.xyz" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:4533";
      };
    };
  };
}
