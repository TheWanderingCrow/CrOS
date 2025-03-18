{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services = {
    trilium-server = {
      enable = true;
      package = pkgs.trilium-next-server;
      instanceName = "WanderingCrow";
      port = 8090;
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "notes.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "notes.wanderingcrow.net";
          locations."/" = {
            proxyPass = "http://127.0.0.1:8090";
          };
        };
      };
    };
  };
}
