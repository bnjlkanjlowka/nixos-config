{ config, ... }:

{
  sops = {
    secrets.lastfm-keys = {
      sopsFile = ../../../secrets/navidrome/lastfm.env;
      format = "dotenv";
    };
  };

  services.navidrome = {
    enable = true;
    environmentFile = config.sops.secrets.lastfm-keys.path;
    settings = {
      MusicFolder = "/data/music";
      Address = "[fd00:30::2]";
    };
  };

  users.groups.music = {
    gid = 1007;
    members = [
      "bnjlka"
      "navidrome"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 4533 ];
}
