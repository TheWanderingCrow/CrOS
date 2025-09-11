{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    trilium-server = {
      enable = true;
      package = pkgs.trilium-next-server;
      instanceName = "WanderingCrow";
      port = 8090;
    };

    caddy = {
      enable = true;
      virtualHosts."notes.wanderingcrow.net".extraConfig = ''
        reverse_proxy http://127.0.0.1:8090
      '';
    };
  };
}
