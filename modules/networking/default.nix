{ ... }:

{
  imports = [
    ./tproxy-xray
    ./xray.nix
  ];

  services.resolved = {
    enable = true;
  };
}
