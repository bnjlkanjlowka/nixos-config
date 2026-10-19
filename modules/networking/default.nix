{ ... }:

{
  services.resolved = {
    enable = true;
  };

  networking = {
    nftables.enable = true;

    firewall.extraInputRules = ''
      ip saddr 185.73.23.0/24 drop
    '';
  };
}
