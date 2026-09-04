{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop-rocm
  ];

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop-rocm}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };

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
