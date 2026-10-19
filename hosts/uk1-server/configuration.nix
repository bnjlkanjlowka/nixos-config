# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/services/3x-ui.nix
    ../../modules/services/nginx.nix

    ../../modules/system
    ../../modules/system/users.nix
    ../../modules/system/boot/grub.nix
    ../../modules/system/auto-upgrade.nix

    ../../modules/networking

    ../../modules/packages

    ../../modules/git.nix
  ];

  networking = {
    hostName = "uk1-server";
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-wired" = {
        matchConfig.Name = "ens18";
        address = [
          "91.149.238.123/24"
          "2605:e440:8::1:393/118"
        ];
        gateway = [
          "91.149.238.1"
          "2605:e440:8::1"
        ];
        dns = [
          "1.1.1.1"
          "2001:4860:4860::8888"
        ];
      };
    };
  };

  services.resolved = {
    enable = true;
  };

  services.getty.autologinUser = "bnjlka";

  home-manager = {
    backupFileExtension = "backup";
    users.bnjlka = {
      home.stateVersion = "26.05";
    };
  };

  nix.distributedBuilds = true;

  nix.buildMachines = [
    {
      hostName = "server";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 4;
      speedFactor = 2;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
    }
  ];

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
