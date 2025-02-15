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
        "d ${volumePath}/umami"
      ];
      ###########
      # Service #
      ###########

      sops = {
        secrets."umami/secret" = {};
        secrets."umami/db_url" = {};
        secrets."umami/db_pass" = {};
        templates."umami-env".content = ''
          APP_SECRET=${config.sops.placeholder."umami/secret"}
          DATABASE_TYPE=postgresql
          DATABASE_URL=${config.sops.placeholder."umami/db_url"}
        '';
        templates."umami-db".content = ''
          POSTGRES_DB=umami
          POSTGRES_USER=umami
          POSTGRES_PASSWORD=${config.sops.placeholder."umami/db_pass"}
        '';
      };

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts = {
          "umami.wanderingcrow.net" = {
            forceSSL = true;
            useACMEHost = "umami.wanderingcrow.net";
            locations."/" = {
              proxyPass = "http://10.88.0.6:3000";
              proxyWebsockets = true;
            };
          };
        };
      };

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          "umami" = {
            image = "ghcr.io/umami-software/umami:postgresql-latest";
            dependsOn = ["umami-db"];
            extraOptions = ["--ip=10.88.0.6"];
            environmentFiles = [config.sops.templates."umami-env".path];
          };
          "umami-db" = {
            image = "postgres:15-alpine";
            volumes = ["${volumePath}/umami:/var/lib/postgresql/data"];
            extraOptions = ["--ip=10.88.0.7"];
            environmentFiles = [config.sops.templates."umami-db".path];
          };
        };
      };
    }
