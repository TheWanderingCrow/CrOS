{inputs, ...}: {
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "swgalaxyproject.com" = {
        forceSSL = true;
        useACMEHost = "swgalaxyproject.com";
        locations."/" = {
          proxyPass = "http://localhost:8080";
          proxyWebsockets = true;
        };
      };
      "test.swgalaxyproject.com" = {
        forceSSL = true;
        useACMEHost = "test.swgalaxyproject.com";
        locations."/" = {
          proxyPass = "http://localhost:8080";
          proxyWebsockets = true;
        };
      };
    };
  };
}
