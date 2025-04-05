let
  volumePath = "/overseer/services";
in
  {
    lib,
    config,
    ...
  }:
    lib.mkIf config.user.overseer.enable {
      systemd.tmpfiles.rules = [
        "d ${volumePath}/barcodebuddy"
      ];

      services.nginx.virtualHosts = {
        "grocy.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "grocy.wanderingcrow.net";
        };
        "barcodebuddy.grocy.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "barcodebuddy.grocy.wanderingcrow.net";
          locations."/" = {
            proxyPass = "http://10.88.0.11:80";
            proxyWebsockets = true;
          };
        };
      };

      services.grocy = {
        enable = true;
        hostName = "grocy.wanderingcrow.net";
        nginx.enableSSL = false;
      };

      virtualisation.oci-containers.containers = {
        barcodebuddy = {
          image = "f0rc3/barcodebuddy:latest";
          volumes = ["${volumePath}/barcodebuddy:/config"];

          extraOptions = ["--ip=10.88.0.11"];
        };
      };
    }
