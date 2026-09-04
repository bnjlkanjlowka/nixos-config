{ ... }:

{
  services.transmission = {
    enable = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      download-dir = "/data";
    };

    openRPCPort = true;
    openPeerPorts = true;
  };
}
