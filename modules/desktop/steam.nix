{ pkgs, ... }:

let
  proton = with pkgs; [
    proton-ge-11-5
    proton-ge-11-7
  ];
in
{
  programs.steam = {
    enable = true;
    extraCompatPackages = proton;
  };

  environment.sessionVariables = {
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_ENABLE_HDR = "1";
    PROTON_FSR4_UPGRADE = "1";
  };

  home-manager.users.bnjlka = {
    programs.lutris = {
      enable = true;
      protonPackages = proton;
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
