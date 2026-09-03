# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/services/pihole.nix
    ../../modules/services/unbound.nix
    ../../modules/services/navidrome.nix

    ../../modules/system
    ../../modules/system/users.nix

    ../../modules/packages

    ../../modules/git.nix
  ];

  networking = {
    hostName = "server";
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-wired" = {
        matchConfig.Name = "ens18";
        networkConfig = {
          DHCP = "yes";
          IPv6AcceptRA = true;
        };
        dhcpV4Config = {
          UseDNS = true;
          UseDomains = true;
        };
      };
    };
  };

  services.resolved = {
    enable = lib.mkForce false;
    settings.Resolve = {
      DNSStubListener = "no";
    };
  };

  hardware.graphics = {
    enable = true;
  };

  home-manager = {
    backupFileExtension = "backup";
    users.bnjlka = {
      home.stateVersion = "26.05";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
