{ ... }:

{
  services.navidrome = {
    enable = true;
    settings.MusicFolder = "/data/music";
    settings.Address = "0.0.0.0";
    openFirewall = true;
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
