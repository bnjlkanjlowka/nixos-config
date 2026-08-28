{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    lutris
  ];

  home-manager.users.bnjlka = {
    programs.lutris = {
      protonPackages = [
        pkgs.proton-ge-bin
      ];
      extraPackages = with pkgs; [
        umu-launcher
        winetricks
        mangohud
        gamescope
        gamemode
      ];
    };
  };
}
