{inputs, ...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "chat.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "chat.wanderingcrow.net";
        locations."/" = {
          extraConfig = ''
            allow 192.168.0.0/16;
            allow ${inputs.nix-secrets.network.primary.publicIP};
            deny all;
          '';
          proxyPass = "http://192.168.0.72:3000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
