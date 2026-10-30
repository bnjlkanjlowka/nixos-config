{ ... }:

{
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export         192.168.30.0/24(rw,fsid=0)
    /export/data  192.168.30.0/24(rw,insecure)
    /export/nixos-config  192.168.30.0/24(rw,insecure)
  '';

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
