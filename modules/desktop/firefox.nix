{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings =
        let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in
        {
          "enhancerforyoutube@maximerf.addons.mozilla.org" = {
            install_url = moz "enhancer-for-youtube";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "suziwen1@gmail.com" = {
            install_url = moz "zeroomega";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
            # TWP - Translate Web Pages addon
            install_url = moz "traduzir-paginas-web";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            #Bitwarden addon
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "sponsorBlocker@ajay.app" = {
            install_url = moz "sponsorblock";
            installation_mode = "force_installed";
            updates_disabled = true;
          };

          "ff2mpv@yossarian.net" = {
            install_url = moz "ff2mpv";
            installation_mode = "force_installed";
            updates_disable = true;
          };
        };
    };
    #for ff2mpv addon firefox
    nativeMessagingHosts.packages = with pkgs; [
      ff2mpv-rust
    ];
  };

  home-manager.users.bnjlka = {
    programs.firefox = {
      profiles.default = {
        settings = {
          "sidebar.verticalTabs" = true;
          "sidebar.revamp" = true;
        };
      };
    };
  };
}
