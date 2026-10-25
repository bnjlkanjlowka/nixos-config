{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./btop.nix
  ];

  #nix settings
  nix = {
    settings.extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
    #garbage collector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  #fonts
  fonts.packages = with pkgs; [
    nerd-fonts.lilex
  ];

  #locale
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  #keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #sshd
  services.openssh = {
    enable = true;
    ports = [ 1285 ];
    settings = {
      PermitRootLogin = "no";
    };
  };

  #ssh client
  programs.ssh = {
    extraConfig = ''
      Host server
        HostName bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host ru1-server
        HostName ru1.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host ru2-server
        HostName ru2.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host usa1-server
        HostName usa1.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host nl1-server
        HostName nl1.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host uk1-server
        HostName uk1.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host gr1-server
        HostName gr1.ww.bnjlkanjlowka.xyz
        User bnjlka
        Port 1285

      Host router
        HostName 192.168.30.1
        User bnjlka
        Port 1285
    '';
  };

  #secrets
  sops = {
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

  #run0
  security.run0 = {
    enable = true;
    wheelNeedsPassword = false;
  };
}
