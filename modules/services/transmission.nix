{ ... }:

{
  services.transmission = {
    enable = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "127.0.0.1,192.168.*.*,10.0.10.*";
      rpc-host-whitelist = "server.*";
      download-dir = "/data";
    };

    openRPCPort = true;
    openPeerPorts = true;
  };
}
