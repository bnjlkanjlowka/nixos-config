{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.firejail.enable = true;

  environment.systemPackages = with pkgs; [
    zed-editor
    nixd
    nil
    package-version-server
    btop
    bluetuith
    feishin
    discord
    spotify
  ];

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };

  programs.firejail.wrappedBinaries = {
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
}
