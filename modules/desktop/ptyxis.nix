{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.ptyxis
  ];

  home-manager.users.bnjlka = {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/Ptyxis" = {
          default-profile-uuid = "f294612757ce57fc1cfb5e3a6a93e100";
          profile-uuids = [
            "f294612757ce57fc1cfb5e3a6a93e100"
          ];
          font-name = "Adwaita Mono 14";
          use-system-font = false;
        };
        "org/gnome/Ptyxis/Profiles/f294612757ce57fc1cfb5e3a6a93e100" = {
          opacity = "1.0";
          palette = "Dark Pastel";
        };

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Terminal";
          command = "ptyxis -s";
          binding = "<Super>Return";
        };
      };
    };
  };
}
