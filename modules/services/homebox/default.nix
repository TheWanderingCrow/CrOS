{inputs, ...}: {
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "homebox.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "homebox.wanderingcrow.net";
          locations."/" = {
            extraConfig = ''
              allow 192.168.0.0/16;
              allow 10.8.0.0/24;
              allow ${inputs.nix-secrets.network.primary.publicIP}
              deny all;
            '';
            proxyPass = "http://localhost:7745";
            proxyWebsockets = true;
          };
        };
      };
    };

    homebox = {
      enable = true;
      settings = {
        HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
      };
    };
  };
}
