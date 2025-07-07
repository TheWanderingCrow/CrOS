{config, ...}: let
  volumePath = "/overseer/services";
in {
  sops.secrets = {
    "tubearchivist/secret" = {};
  };

  sops.templates = {
    tubearchivist.content = ''
      TA_PASSWORD=${config.sops.placeholder."tubearchivist/secret"}
      ELASTIC_PASSWORD=${config.sops.placeholder."tubearchivist/secret"}
    '';
    archivist-es.content = ''
      ELASTIC_PASSWORD=${config.sops.placeholder."tubearchivist/secret"}
    '';
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "ta.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "ta.wanderingcrow.net";
        locations = {
          "/" = {
            proxyPass = "http://10.88.0.14:8000";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d ${volumePath}/tubearchivist"
    "d ${volumePath}/tubearchivist/redis"
    "d ${volumePath}/tubearchivist/es - 1000 0"
    "d ${volumePath}/tubearchivist/ta/youtube"
    "d ${volumePath}/tubearchivist/ta/cache"
  ];
  virtualisation.oci-containers.containers = {
    tubearchivist = {
      image = "bbilly1/tubearchivist";
      extraOptions = ["--ip=10.88.0.14"];
      volumes = [
        "${volumePath}/tubearchivist/ta/youtube:/youtube"
        "${volumePath}/tubearchivist/ta/cache:/cache"
      ];
      environment = {
        ES_URL = "http://10.88.0.16:9200";
        REDIS_CON = "redis://10.88.0.15:6379";
        HOST_UID = "1000";
        HOST_GID = "1000";
        TA_HOST = "https://ta.wanderingcrow.net";
        TA_USERNAME = "admin";
        TZ = "America/New_York";
      };
      environmentFile = config.sops.templates.tubearchivist.path;
      dependsOn = [
        "archivist-redis"
        "archivist-es"
      ];
    };
    archivist-redis = {
      image = "redis";
      extraOptions = [
        "--ip=10.88.0.15"
        "--ulimit=memlock=-1:-1"
      ];
      volumes = [
        "${volumePath}/tubearchivist/redis:/data"
      ];
      dependsOn = [
        "archivist-es"
      ];
    };
    archivist-es = {
      image = "elasticsearch:8.18.0";
      extraOptions = ["--ip=10.88.0.16"];
      environment = {
        ES_JAVA_OPTS = "-Xms1g -Xmx1g";
        "xpack.security.enabled" = "true";
        "discovery.type" = "single-node";
        "path.repo" = "/usr/share/elasticsearch/data/snapshot";
      };
      environmentFile = config.sops.templates.archivist-es.path;
      volumes = [
        "${volumePath}/tubearchivist/es:/usr/share/elasticsearch/data"
      ];
    };
  };
}
