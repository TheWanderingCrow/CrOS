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
      # Some scafolding for secrets

      # Create the dirs we need
      systemd.tmpfiles.rules = [
        "d ${volumePath}"

        "d ${volumePath}/bar-assistant"
        "d ${volumePath}/meilisearch"
      ];

      # (Arguably) Most Important Service - backups
      services.restic.backups = {
        homebox = {
          user = "root";
          timerConfig = {
            OnCalendar = "hourly";
            Persistent = true;
          };
          paths = [
            "/var/lib/homebox/data"
          ];
          repositoryFile = config.sops.secrets."restic/url".path;
          passwordFile = config.sops.secrets."restic/key".path;
        };
      };

      # These ports are needed for NGINX Proxy Manager
      networking.firewall.allowedTCPPorts = [
        443
        80
      ];

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts = {
          "homebox.wanderingcrow.net" = {
            locations."/" = {
              proxyPass = "http://localhost:7745";
              proxyWebsockets = true;
            };
          };
          "home.wanderingcrow.net" = {
            locations."/" = {
              extraConfig = ''
                allow 192.168.0.0/16;
                deny all;
              '';
              proxyPass = "http://localhost:8082";
              proxyWebsockets = true;
            };
          };
          "bar.wanderingcrow.net" = {
            extraConfig = ''
              allow 192.168.0.0/16;
              deny all;
            '';
            locations = {
              "/bar/" = {
                proxyPass = "http://localhost:3000";
              };
              "/search/" = {
                proxyPass = "http://localhost:7700";
              };
              "/" = {
                proxyPass = "http://localhost:3001";
              };
            };
          };
        };
      };

      services = {
        homebox = {
          enable = true;
          settings = {
            HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
          };
        };
        homepage-dashboard = {
          enable = true;
          environmentFile = config.sops.templates."homepage-environment".path;
          settings = {
            theme = "dark";
          };
          widgets = [
            {
              search = {
                provider = "duckduckgo";
                target = "_blank";
              };
            }
            {
              openmeteo = {
                timezone = "America/New_York";
                units = "imperial";
                cache = "5";
                latitude = "{{HOMEPAGE_VAR_LAT}}";
                longitude = "{{HOMEPAGE_VAR_LONG}}";
              };
            }
          ];
          bookmarks = [
            {
              WCE = [
                {
                  Homebox = [
                    {
                      icon = "http://homebox.wanderingcrow.net/favicon.svg";
                      href = "http://homebox.wanderingcrow.net";
                    }
                  ];
                }
              ];
            }
            {
              "Day to Day" = [
                {
                  Messages = [
                    {
                      icon = "google-messages.svg";
                      href = "https://messages.google.com/web";
                    }
                  ];
                }
                {
                  YouTube = [
                    {
                      icon = "youtube.svg";
                      href = "https://youtube.com";
                    }
                  ];
                }
                {
                  "Proton Mail" = [
                    {
                      icon = "proton-mail.svg";
                      href = "https://mail.proton.me";
                    }
                  ];
                }
                {
                  Instagram = [
                    {
                      icon = "instagram.svg";
                      href = "https://instagram.com";
                    }
                  ];
                }
                {
                  Aetolia = [
                    {
                      icon = "https://aetolia.com/wp-content/uploads/2020/04/favicon.ico";
                      href = "https://aetolia.com";
                    }
                  ];
                }
                {
                  Amazon = [
                    {
                      icon = "amazon.svg";
                      href = "https://amazon.com";
                    }
                  ];
                }
              ];
            }
          ];
        };
      };

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          "meilisearch" = {
            image = "getmeili/meilisearch:v1.8";
            volumes = ["${volumePath}/meilisearch:/meili_data"];
            ports = ["7700:7700"];
            environmentFile = [config.sops.templates."meilisearch-environment".path];
            environment = {
              MEILI_ENV = "production";
            };
          };
          "bar-assistant" = {
            image = "barassistant/server:v4";
            volumes = ["${volumePath}/bar-assistant:/var/www/cocktails/storage/bar-assistant"];
            ports = ["3000:3000"];
            dependsOn = ["meilisearch"];
            environmentFile = [config.sops.templates."barassistant-environment".path];
            environment = {
              APP_URL = "bar.wanderingcrow.net/bar";
              MEILISEARCH_HOST = "http://localhost:7700";
              CACHE_DRIVER = "file";
              SESSION_DRIVER = "file";
              ALLOW_REGISTRATION = "true";
            };
          };
          "salt-rim" = {
            image = "barassistant/salt-rim:v3";
            ports = ["3001:8080"];
            dependsOn = ["bar-assistant"];
            environment = {
              API_URL = "bar.wanderingcrow.net/bar";
              MEILIESEARCH_URL = "bar.wanderingcrow.net/search";
            };
          };
        };
      };
    }
