{ ... }:

{
  programs.git.enable = true;

  home-manager.users.bnjlka = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "bnjlka";
        email = "dolwans12@gmail.com";
      };
    };
  };
}
