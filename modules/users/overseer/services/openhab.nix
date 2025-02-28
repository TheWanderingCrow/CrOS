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
          user = "openhab:openhab";
          volumes = [
            "${volumePath}/openhab/conf:/openhab/conf"
            "${volumePath}/openhab/userdata:/openhab/userdata"
            "${volumePath}/openhab/addons:/openhab/addons"
          ];
        };
      };
    }
