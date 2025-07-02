let
  volumePath = "/overseer/services";
in
  {
    lib,
    config,
    ...
  }: {
    ###########
    # SECRETS #
    ###########

    sops = {
      # Meilisearch secrets
      secrets."meilisearch/masterkey" = {};
      templates."meilisearch-environment".content = ''
        MEILI_MASTER_KEY=${config.sops.placeholder."meilisearch/masterkey"}
      '';

      # Bar Assistant secrets
      templates."bar_assistant-env".content = ''
        MEILISEARCH_KEY=${config.sops.placeholder."meilisearch/masterkey"}
      '';
    };

    systemd.tmpfiles.rules = [
      "d ${volumePath}/bar-assistant 770 33 33"
      "d ${volumePath}/meilisearch"
    ];

    ###########
    # Routing #
    ###########

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "bar.wanderingcrow.net" = {
          extraConfig = ''
            allow 192.168.0.0/16;
            allow 10.8.0.0/24;
            allow 172.220.132.255;
            deny all;
          '';
          forceSSL = true;
          useACMEHost = "bar.wanderingcrow.net";
          locations = {
            "/search/" = {
              proxyPass = "http://10.88.0.3:7700/";
              priority = 1;
            };
            "/api/" = {
              proxyPass = "http://10.88.0.4:8080/";
              priority = 1;
            };
            "/" = {
              proxyPass = "http://10.88.0.5:8080/";
            };
          };
        };
      };
    };

    ###########
    # Service #
    ###########

    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        "meilisearch" = {
          image = "getmeili/meilisearch:v1.8";
          volumes = ["${volumePath}/meilisearch:/meili_data"];
          extraOptions = ["--ip=10.88.0.3"];
          environmentFiles = [config.sops.templates."meilisearch-environment".path];
          environment = {
            MEILI_ENV = "production";
            MEILI_NO_ANALYTICS = "true";
          };
        };
        "bar-assistant" = {
          image = "barassistant/server:v4";
          volumes = ["${volumePath}/bar-assistant:/var/www/cocktails/storage/bar-assistant"];
          dependsOn = ["meilisearch"];
          extraOptions = ["--ip=10.88.0.4"];
          environmentFiles = [config.sops.templates."bar_assistant-env".path];
          environment = {
            APP_URL = "https://bar.wanderingcrow.net/api";
            MEILISEARCH_HOST = "https://bar.wanderingcrow.net/search";
            CACHE_DRIVER = "file";
            SESSION_DRIVER = "file";
            ALLOW_REGISTRATION = "true";
          };
        };
        "salt-rim" = {
          image = "barassistant/salt-rim:v3";
          dependsOn = ["bar-assistant"];
          extraOptions = ["--ip=10.88.0.5"];
          ports = ["3001:8080"];
          environment = {
            API_URL = "https://bar.wanderingcrow.net/api";
            MEILIESEARCH_URL = "https://bar.wanderingcrow.net/search";
          };
        };
      };
    };
  }

