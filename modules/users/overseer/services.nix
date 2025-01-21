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
      sops = {
        defaultSopsFile = inputs.nix-secrets.secrets.overseer;
        age.keyFile = "/var/lib/sops-nix/key.txt";
        age.generateKey = true;
      };

      # Create the dirs we need
      systemd.tmpfiles.rules = [
        "d ${volumePath}"
      ];

      # Pull in the restic secrets from sops
      sops.secrets."restic/url" = {};
      sops.secrets."restic/key" = {};
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

      # OCI services
      virtualisation.podman.enable = true;
      virtualisation.oci-containers.backend = "podman";

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
              proxyPass = "http://localhost:8082";
              proxyWebsockets = true;
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
    }
