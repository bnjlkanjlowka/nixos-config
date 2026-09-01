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
    dconf = {
      enable = true;
      settings = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Terminal";
          command = "alacritty";
          binding = "<Super>Return";
        };
      };
    };
  };
}
