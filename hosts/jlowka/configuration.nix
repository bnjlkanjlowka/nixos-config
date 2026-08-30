# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/desktop/gnome.nix
    ../../modules/desktop/ptyxis.nix
    ../../modules/desktop/firefox.nix
    ../../modules/desktop/mpv.nix
    ../../modules/desktop/git.nix

    ../../modules/networking
    ../../modules/networking/xray.nix
    ../../modules/networking/tproxy-xray/tproxy-xray.nix
    ../../modules/networking/wireguard.nix

    ../../modules/system
    ../../modules/system/packages.nix
    ../../modules/system/users.nix
  ];

  home-manager.backupFileExtension = "backup";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "jlowka"; # Define your hostname.

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  home-manager.users.bnjlka = {
    home.stateVersion = "26.05";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
