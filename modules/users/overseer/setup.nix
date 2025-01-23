let
  volumePath = "/overseer/services";
in
  {
    lib,
    inputs,
    config,
    pkgs,
    ...
  }:
    lib.mkIf config.user.overseer.enable {
      # Base dir
      systemd.tmpfiles.rules = [
        "d ${volumePath}"
      ];

      # NGINX Ports
      networking.firewall.allowedTCPPorts = [
        443
        80
      ];

      # Pin virtualisation backend to podman
      virtualisation.oci-containers.backend = "podman";
    }
