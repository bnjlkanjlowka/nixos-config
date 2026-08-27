{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mpv
    mpvScripts.mpris
    yt-dlp
  ];

  home-manager.users.bnjlka = {
    programs.mpv = {
      enable = true;
      bindings = {
        "9" = "add ao-volume -2";
        "0" = "add ao-volume 2";
      };
    };

    programs.yt-dlp = {
      enable = true;
      settings = {
        proxy = "socks5://127.0.0.1:1082";
        cookies = "/home/bnjlka/.config/yt-dlp/cookies.txt";
      };
    };
  };
}
