{ pkgs, ... }:

{
  home-manager.users.bnjlka = {
    programs.zed-editor = {
      enable = true;
      extraPackages = [
        pkgs.nil
        pkgs.nixd
      ];
      extensions = [
        "nix"
      ];
    };
  };
}
