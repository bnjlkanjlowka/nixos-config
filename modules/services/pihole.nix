{ ... }:

{
  services = {
    pihole-ftl = {
      enable = true;
    };
    pihole-web = {
      enable = true;
      ports = [ "8080" ];
    };
  };
}
