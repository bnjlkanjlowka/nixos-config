{ ... }:

{
  home-manager.users.bnjlka = {
    programs.btop = {
      enable = true;
      settings = {
        update_ms = 100;
        disks_filter = "/ /boot /data";
      };
    };
  };
}
