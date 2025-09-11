{
  lib,
  config,
  ...
}: let
  volumePath = "/overseer/services";
in {
  systemd.tmpfiles.rules = [
    "d ${volumePath}/actualbudget"
  ];

  services.caddy = {
    enable = true;
    virtualHosts."budget.wanderingcrow.net".extraConfig = ''
      reverse_proxy http://10.88.0.12
    '';
  };
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      "actualbudget" = {
        image = "actualbudget/actual-server:latest";
        volumes = ["${volumePath}/actualbudget:/data"];
        extraOptions = ["--ip=10.88.0.12"];
        environment = {
          ACTUAL_PORT = "80";
        };
      };
    };
  };
}
