{ pkgs, ... }:

{
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    btop-rocm
    rocmPackages.rocm-smi
    wget
  ];

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop-rocm}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
