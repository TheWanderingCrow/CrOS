let
  volumePath = "/overseer/services";
in
  {
    lib,
    config,
    inputs,
    ...
  }: {
    systemd.tmpfiles.rules = [
      "d ${volumePath}/openhab"
      "d ${volumePath}/openhab/conf"
      "d ${volumePath}/openhab/userdata"
      "d ${volumePath}/openhab/addons"
    ];
    ###########
    # Service #
    ###########

    virtualisation.oci-containers = {
      backend = "podman";
      containers."openhab" = {
        image = "openhab/openhab:5.0.0.M1";
        extraOptions = ["--ip=10.88.0.9"];
        volumes = [
          "${volumePath}/openhab/conf:/openhab/conf"
          "${volumePath}/openhab/userdata:/openhab/userdata"
          "${volumePath}/openhab/addons:/openhab/addons"
        ];
      };
    };

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "openhab.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "openhab.wanderingcrow.net";
          locations."/" = {
            extraConfig = ''
              allow 192.168.0.0/16;
              allow ${inputs.nix-secrets.network.primary.publicIP};
              deny all;
            '';
            proxyPass = "http://10.88.0.9:8080";
          };
        };
      };
    };
  }
