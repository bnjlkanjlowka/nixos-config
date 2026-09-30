{ pkgs, ... }:

let
  proton = with pkgs; [
    proton-ge-11-5
    proton-ge-11-6
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
        gamescope
        gamemode
      ];
    };

    programs.mangohud = {
      enable = true;
      settings = {
        no_display = true;
        vram = true;
        gpu_power = true;
        cpu_power = true;
        cpu_temp = true;
        gpu_temp = true;
        wine = true;
        fps_metrics = "0.01,0.001";
      };
    };
  };
}
