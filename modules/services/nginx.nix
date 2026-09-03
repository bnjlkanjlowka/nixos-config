{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "dolwans12@gmail.com";
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "music.bnjlkanjlowka.xyz" = {
        enableACME = true;
        forceSSL = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:4533";
        };
      };
    };
  };
}
