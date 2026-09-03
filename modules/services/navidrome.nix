{ ... }:

{
  services.navidrome = {
    enable = true;
    settings.MusicFolder = "/data/music";
    openFirewall = true;
  };

  users.groups = {
    music = {
      gid = 1007;
      members = [
        "bnjlka"
        "navidrome"
      ];
    };
  };
}
