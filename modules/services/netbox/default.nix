{
  inputs,
  config,
  pkgs,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
in {
  users.users.nginx.extraGroups = ["netbox"];

  sops.secrets."netbox/secret-key" = {
    owner = "netbox";
    sopsFile = "${sopsFolder}/shared.yaml";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true; # otherwise you will get CSRF error while login
    virtualHosts."netbox.wanderingcrow.net" = {
      forceSSL = true;
      useACMEHost = "netbox.wanderingcrow.net";
      locations = {
        "/" = {
          proxyPass = "http://${config.services.netbox.listenAddress}:${builtins.toString config.services.netbox.port}";
        };
        "/static/" = {alias = "${config.services.netbox.dataDir}/static/";};
      };
    };
  };

  services.netbox = {
    enable = true;
    package = pkgs.netbox;
    listenAddress = "0.0.0.0";
    port = 9099;
    secretKeyFile = config.sops.secrets."netbox/secret-key".path;
  };
}
