{
  pkgs,
  ...
}:

{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome.core-apps.enable = false;
  };

  environment.systemPackages = with pkgs; [
    nautilus
    papers
    gnomeExtensions.blur-my-shell
    gnomeExtensions.clipboard-history
    gnomeExtensions.disable-workspace-switcher-overlay
    gnomeExtensions.mpris-label
  ];

  home-manager.users.bnjlka = { lib, ... }: {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark"; # dark theme
        };

        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "us"
            ])
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "ru"
            ])
          ];
          per-window = true;
        };

        "org/gnome/shell" = {
          enabled-extensions = with pkgs.gnomeExtensions; [
            blur-my-shell.extensionUuid
            clipboard-history.extensionUuid
            disable-workspace-switcher-overlay.extensionUuid
            mpris-label.passthru.extensionUuid
          ];
          favorite-apps = [
            "firefox.desktop"
          ];
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = false;
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = 5;
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super>q" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" ];
          move-to-monitor-down = [ "<Super><Shift>s" ];
          move-to-monitor-up = [ "<Super><Shift>w" ];
          move-to-monitor-left = [ "<Super><Shift>a" ];
          move-to-monitor-right = [ "<Super><Shift>d" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          maximize = [ "<Super>w" ];
          minimize = [ "<Super>s" ];

          switch-input-source = [
            "<Shift>Alt_L"
            "<Alt>Shift_L"
          ];
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ "<Super>a" ];
          toggle-tiled-right = [ "<Super>d" ];
        };

        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [ ];
          switch-to-application-2 = [ ];
          switch-to-application-3 = [ ];
          switch-to-application-4 = [ ];
          switch-to-application-5 = [ ];
          switch-to-application-6 = [ ];
          switch-to-application-7 = [ ];
          switch-to-application-8 = [ ];
          switch-to-application-9 = [ ];
          toggle-application-view = [ ];
          toggle-quick-settings = [ ];
          toggle-message-tray = [ ];
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

        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
      };
    };
  };
}
