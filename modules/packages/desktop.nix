{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetuith
    feishin
    discord
    spotify
    easyeffects
    obs-studio
    moonlight-qt
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vaapi
    ];
  };

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      Discord = {
        executable = "${pkgs.discord}/bin/Discord";
        desktop = "${pkgs.discord}/share/applications/discord.desktop";
        extraArgs = [
          "--noprofile"
          "--netns=proxy"
          "--blacklist=/var/run/nscd"
        ];
      };
    };
  };
}
