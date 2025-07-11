{
  nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "chat.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "chat.wanderingcrow.net";
        locations."/" = {
          proxyPass = "http://192.168.0.72:3000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
