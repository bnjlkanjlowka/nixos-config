{ ... }:

{
  services.transmission = {
    enable = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      download-dir = "/data";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      9091
      51413
    ];
    allowedUDPPorts = [
      9091
      51413
    ];
  };
}
