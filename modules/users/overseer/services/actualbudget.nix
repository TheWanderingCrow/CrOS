{...}: let
  volumePath = "/overseer/services";
in {
  systemd.tmpfiles.rules = [
    "d ${volumePath}/actualbudget"
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "budget.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "budget.wanderingcrow.net";
        locations = {
          "/" = {
            proxyPass = "http://10.88.0.12";
          };
        };
      };
    };
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
