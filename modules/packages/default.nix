{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop-rocm
    wget
  ];

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop-rocm}/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
}
