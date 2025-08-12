{
  config,
  pkgs,
  ...
}: {
  users.users.nginx.extraGroups = ["netbox"];

  sops.secrets."netbox/secret-key" = {};

  services.nginx = {
    enable = true;
    recommendedProxySettings = true; # otherwise you will get CSRF error while login
    virtualHosts."netbox.wanderingcrow.net" = {
      locations = {
        "/" = {
          proxyPass = "/run/netbox/netbox.sock";
        };
        "/static/" = {alias = "${config.services.netbox.dataDir}/static/";};
      };
    };
  };

  services.netbox = {
    enabled = true;
    unixSocket = "/run/netbox/netbox.sock";
    secretKeyFile = config.sops.secrets."netbox/secret-key".path;
  };
}
