{ pkgs, ... }:

{
  imports = [
    ./fish.nix
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

  #pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  #secrets
  sops = {
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

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
