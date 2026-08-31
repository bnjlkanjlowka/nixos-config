{ pkgs, ... }:

{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    btop
    wget
  ];

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
