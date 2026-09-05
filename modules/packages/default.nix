{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    p7zip
  ];
}
