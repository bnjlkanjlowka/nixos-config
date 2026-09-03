{ ... }:

{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/data/immich";
    # `null` will give access to all devices.
    # You may want to restrict this by using something like `[ "/dev/dri/renderD128" ]`
    accelerationDevices = null;
  };

  users.groups = {
    vid = {
      gid = 1005;
      members = [
        "bnjlka"
        "immich"
      ];
    };
  };

  users.users = {
    immich = {
      uid = 960;
      extraGroups = [
        "video"
        "render"
      ];
    };
  };
}
