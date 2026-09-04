{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "movie";
    cacheDir = "/data/jellyfin-cache";

    hardwareAcceleration = {
      enable = true;
      device = "/dev/dri/renderD128";
      type = "vaapi";
    };
  };

  users.groups = {
    movie = {
      gid = 1004;
      members = [
        "bnjlka"
        "jellyfin"
      ];
    };
  };
}
