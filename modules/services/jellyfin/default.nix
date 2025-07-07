{
  config,
  lib,
  pkgs,
  ...
}: let
  volumePath = "/overseer/services";
in {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Tube Archivist
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
        TA_HOST = "http://192.168.0.30:8000";
        TA_USERNAME = "tubearchivist";
        TA_PASSWORD = "verysecret";
        ELASTIC_PASSWORD = "verysecret";
        TZ = "America/New_York";
      };
      dependsOn = [
        "archivist-redis"
        "archivist-es"
      ];
    };
    archivist-redis = {
      image = "redis";
      extraOptions = ["--ip=10.88.0.15"];
      volumes = [
        "${volumePath}/tubearchivist/redis:/data"
      ];
      dependsOn = [
        "archivist-es"
      ];
    };
    archivist-es = {
      image = "bbilly1/tubearchivist-es";
      extraOptions = ["--ip=10.88.0.16"];
      environment = {
        ELASTIC_PASSWORD = "verysecret";
        ES_JAVA_OPTS = "-Xms1g -Xmx1g";
        "xpack.security.enabled" = "true";
        "discovery.type" = "single-node";
        "path.repo" = "/usr/share/elasticsearch/data/snapshot";
      };
      volumes = [
        "${volumePath}/tubearchivist/es:/usr/share/elasticsearch/data"
      ];
    };
  };
}
