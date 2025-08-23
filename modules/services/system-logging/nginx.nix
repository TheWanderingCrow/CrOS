{
  config,
  inputs,
  ...
}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "logs.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "logs.wanderingcrow.net";
        locations."/" = {
          extraConfig = ''
            allow 192.168.0.0/16;
            allow ${inputs.nix-secrets.network.primary.publicIP};
            deny all;
          '';
          proxyPass = "http://${builtins.toString config.services.grafana.settings.server.http_addr}:${builtins.toString config.services.grafana.settings.server.http_port}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
    };
  };
}
