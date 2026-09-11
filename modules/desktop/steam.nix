{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-ge-11-6
    ];
  };

  environment.sessionVariables = {
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_ENABLE_HDR = "1";
  };

  home-manager.users.bnjlka = {
    programs.lutris = {
      enable = true;
      protonPackages = [
        pkgs.proton-ge-bin
        pkgs.proton-ge-11-6
      ];
      extraPackages = with pkgs; [
        winetricks
        mangohud
        gamescope
        gamemode
      ];
    };
  };
}
