{ pkgs, ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
    #last kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
