{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    alacritty-theme
  ];

  home-manager.users.bnjlka = {
    programs.alacritty = {
      enable = true;

      theme = "hyper";
      settings = {
        font = {
          size = 14;
          normal = {
            family = "Adwaita Mono";
            style = "Regular";
          };
        };

        window.startup_mode = "Maximized";
      };
    };
  };
}
