{ pkgs, ... }:

{
  users.users."bnjlka" = {
    isNormalUser = true;
    description = "bnjlka";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
}
