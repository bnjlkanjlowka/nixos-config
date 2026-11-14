{ config, pkgs, ... }:

{
  home-manager.users.bnjlka = {
    programs.mpv = {
      enable = true;
      bindings = {
        "9" = "add ao-volume -2";
        "0" = "add ao-volume 2";
      };
      scripts = [
        pkgs.mpvScripts.mpris
      ];

      config = {
        alang = "en,ru";
        slang = "ru";
        ytdl-format =
          if config.networking.hostName == "jlowka" then
            "bestvideo[height=1080][vcodec*=avc1]+bestaudio"
          else
            "best";
      };
    };

    programs.yt-dlp = {
      enable = true;
      settings = {
        proxy = "socks5://127.0.0.1:1082";
        cookies-from-browser = "firefox";
      };
    };
  };
}
