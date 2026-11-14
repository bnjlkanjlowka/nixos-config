{ ... }:

{
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export (rw,fsid=0)
    /export/data (rw,insecure)
    /export/nixos-config (rw,insecure)
  '';

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
