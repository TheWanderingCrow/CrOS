{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "notify.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "notify.wanderingcrow.net";
        locations."/" = {
          proxyPass = "http://localhost:9089";
          proxyWebsockets = true;
        };
      };
    };
  };
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://notify.wanderingcrow.net";
      listen-http = ":9089";
      behind-proxy = true;
    };
  };
}
