{ pkgs, ... }:

{
  boot = {
    #systemd-boot enable
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    #last kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
