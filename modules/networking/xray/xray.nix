{ config, ... }:

{
  sops = {
    secrets.xray-config = {
      sopsFile = ../../../secrets/xray/config.json;
      format = "json";
      key = "";
    };
  };
  services.xray = {
    enable = true;
    settingsFile = config.sops.secrets.xray-config.path;
  };
}
