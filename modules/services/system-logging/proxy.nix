{
  config,
  inputs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."logs.wanderingcrow.net".extraConfig = ''
      remote_ip ${inputs.nix-secrets.network.primary.publicIP}
      @block not remote_ip private_ranges
      abort @block
      reverse_proxy http://${builtins.toString config.services.grafana.settings.server.http_addr}:${builtins.toString config.services.grafana.settings.server.http_port}
    '';
  };
}
