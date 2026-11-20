{ ... }:

{
  services.radicale = {
    enable = true;
    settings = {
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/etc/radicale/users";
        htpasswd_encryption = "bcrypt";
      };

      server.hosts = "[fd00:30::2]:5232";
    };
  };

  networking.firewall.allowedTCPPorts = [ 5232 ];
}
