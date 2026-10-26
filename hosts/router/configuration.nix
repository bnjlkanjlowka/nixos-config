# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./modules/dnsmasq.nix
    ./modules/firewall.nix
    ./modules/network.nix
    ./modules/tproxy-xray.nix
    ./modules/wireguard.nix
    ./modules/ntp.nix

    ../../modules/system
    ../../modules/system/users.nix
    ../../modules/system/boot/systemd-boot.nix

    ../../modules/packages

    ../../modules/git.nix
  ];

  networking = {
    hostName = "router";
    useNetworkd = true;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv6.conf.default.forwarding" = 1;
  };

  services.getty.autologinUser = "bnjlka";

  home-manager = {
    backupFileExtension = "backup";
    users.bnjlka = {
      home.stateVersion = "26.05";
    };
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
