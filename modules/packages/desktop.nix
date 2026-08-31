{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zed-editor
    nixd
    nil
    package-version-server
    bluetuith
    feishin
    discord
    spotify
  ];

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
