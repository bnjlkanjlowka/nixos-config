{
  config,
  pkgs,
  lib,
  ...
}:

let
  createNamespace =
    pkgs.writers.writeFish "create-namespace"
      {
        makeWrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          "${lib.makeBinPath [
            pkgs.iproute2
            pkgs.nftables
          ]}"
        ];
      }
      ''
        ${builtins.readFile ./create-namespace.fish}
      '';

  deleteNamespace =
    pkgs.writers.writeFish "delete-namespace"
      {
        makeWrapperArgs = [
          "--prefix"
          "PATH"
          ":"
          "${lib.makeBinPath [
            pkgs.iproute2
          ]}"
        ];
      }
      ''
        ${builtins.readFile ./delete-namespace.fish}
      '';
in
{
  environment.etc."tproxy-xray/nft/nft.config" = {
    source = ./nft/nft-tproxy.config;
  };
  environment.etc."netns/proxy/resolv.conf" = {
    source = ./misc/resolv.conf;
  };
  environment.etc."netns/proxy/nsswitch.conf" = {
    source = ./misc/nsswitch.conf;
  };

  systemd.services.tproxy-namespace-create = {
    description = "create proxy namespace";
    after = [
      "network.target"
    ];
    wantedBy = [
      "multi-user.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = createNamespace;
      ExecStop = deleteNamespace;
    };
  };

  sops = {
    secrets."tproxy-xray-config.json" = {
      sopsFile = ../../../secrets/tproxy-xray/xray/config.json;
      format = "json";
      key = "";
    };
  };

  systemd.services.tproxy-namespace-xray = {
    description = "proxy namespace";
    after = [
      "tproxy-namespace-create.service"
    ];
    requires = [
      "tproxy-namespace-create.service"
    ];
    wantedBy = [
      "multi-user.target"
    ];
    serviceConfig = {
      Type = "simple";
      NetworkNamespacePath = "/var/run/netns/proxy";
      TemporaryFileSystem = [
        "/var/run/nscd"
      ];
      BindReadOnlyPaths = [
        "/etc/netns/proxy/resolv.conf:/etc/resolv.conf"
        "/etc/netns/proxy/nsswitch.conf:/etc/nsswitch.conf"
      ];
      ExecStart = "${pkgs.xray}/bin/xray run -c ${config.sops.secrets."tproxy-xray-config.json".path}";
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.100.0/24" ];
  };
}
