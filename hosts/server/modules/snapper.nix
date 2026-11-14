{ ... }:

{
  services.snapper = {
    configs = {
      gtnh = {
        SUBVOLUME = "/opt/gtnh";
        ALLOW_USERS = [ "bnjlka" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
  };

  services.beesd.filesystems."gtnh-and-nixstore" = {
    spec = "UUID=b6bce9f1-3c6c-41a1-a9ff-11ce3832be95";
  };
}
