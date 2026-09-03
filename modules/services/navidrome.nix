{ ... }:

{
  services.navidrome = {
    enable = true;
    settings.MusicFolder = "/data/music";
    settings.Address = "0.0.0.0";
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
