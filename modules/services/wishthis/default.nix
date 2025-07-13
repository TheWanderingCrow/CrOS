{config, ...}: let
  volumePath = "/overseer/services";
in {
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      "wishthis" = {
        image = "hiob/wishthis:stable";
        extraOptions = [
          "--ip=10.88.0.15"
        ];
      };
      "wishthis-db" = {
        image = "mariadb:latest";
        extraOptions = [
          "--ip=10.88.0.16"
        ];
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "wishlist.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "wishlist.wanderingcrow.net";
        locations."/" = {
          proxyPass = "http://10.88.0.15:80";
          proxyWebsockets = true;
        };
      };
    };
  };
}
