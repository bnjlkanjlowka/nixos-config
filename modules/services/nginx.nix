{ ... }:

{
  security.acme = {
    acceptTerms = true;
    defaults.email = "dolwans12@gmail.com";
  };

  services.nginx = {
    enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];
    allowedUDPPorts = [
      80
      443
    ];
  };
}
