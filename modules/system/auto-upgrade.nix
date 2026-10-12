{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "github:bnjlkanjlowka/nixos-config";
    dates = "daily";
  };
}
