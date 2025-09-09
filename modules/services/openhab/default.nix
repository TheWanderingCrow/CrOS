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
        image = "openhab/openhab:milestone";
        extraOptions = ["--ip=10.88.0.9"];
        volumes = [
          "${volumePath}/openhab/conf:/openhab/conf"
          "${volumePath}/openhab/userdata:/openhab/userdata"
          "${volumePath}/openhab/addons:/openhab/addons"
        ];
      };
    };

    services.caddy = {
      enable = true;
      virtualHosts."openhab.wanderingcrow.net" = ''
        remote_ip ${inputs.nix-secrets.network.primary.publicIP};
        @denied not remote_ip private_ranges
        abort @denied
        reverse_proxy http://10.88.0.9:8080
      '';
    };
  }
