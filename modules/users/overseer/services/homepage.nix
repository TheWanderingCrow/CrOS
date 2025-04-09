{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  # Homepage.dev secrets
  sops = {
    secrets = {
      "homepage/openmeteo/lat" = {};
      "homepage/openmeteo/long" = {};
      "lubelogger/user" = {};
      "lubelogger/pass" = {};
    };
    templates."homepage-environment".content = ''
      HOMEPAGE_VAR_LAT = ${config.sops.placeholder."homepage/openmeteo/lat"}
      HOMEPAGE_VAR_LONG = ${config.sops.placeholder."homepage/openmeteo/long"}
      HOMEPAGE_VAR_LUBELOGGERUSER = ${config.sops.placeholder."lubelogger/user"}
      HOMEPAGE_VAR_LUBELOGGERPASS = ${config.sops.placeholder."lubelogger/pass"}
    '';
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "home.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "home.wanderingcrow.net";
        locations."/" = {
          extraConfig = ''
            allow 192.168.0.0/16;
            allow 10.8.0.0/24;
            allow 24.179.20.202;
            deny all;
          '';
          proxyPass = "http://localhost:8089";
          proxyWebsockets = true;
        };
      };
    };
  };

  services = {
    homepage-dashboard = {
      enable = true;
      listenPort = 8089;
      environmentFile = config.sops.templates."homepage-environment".path;
      settings = {
        theme = "dark";
      };
      services = [
        {
          "Services" = [
            {
              "Garage" = {
                icon = "https://garage.wanderingcrow.net/favicon.ico";
                href = "https://garage.wanderingcrow.net";
                description = "Vehicle management";
                widget = {
                  type = "lubelogger";
                  url = "https://garage.wanderingcrow.net";
                  username = "{{HOMEPAGE_VAR_LUBELOGGERUSER}}";
                  password = "{{HOMEPAGE_VAR_LUBELOGGERPASS}}";
                };
              };
            }
          ];
        }
      ];
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
              Grocy = [
                {
                  icon = "grocy.svg";
                  href = "https://grocy.wanderingcrow.net";
                }
              ];
            }
            {
              Homebox = [
                {
                  icon = "https://homebox.wanderingcrow.net/favicon.svg";
                  href = "https://homebox.wanderingcrow.net";
                }
              ];
            }
            {
              Bar = [
                {
                  icon = "https://bar.wanderingcrow.net/favicon.svg";
                  href = "https://bar.wanderingcrow.net";
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
              Crunchyroll = [
                {
                  icon = "https://www.crunchyroll.com/build/assets/img/favicons/favicon-v2-32x32.png";
                  href = "https://crunchyroll.com";
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
        {
          Work = [
            {
              Jira = [
                {
                  icon = "jira.svg";
                  href = "https://home.atlassian.com/";
                }
              ];
            }
            {
              AWS = [
                {
                  icon = "aws.svg";
                  href = "https://console.aws.amazon.com/";
                }
              ];
            }
            {
              Email = [
                {
                  icon = "gmail.svg";
                  href = "https://mail.google.com/mail/u/1/#inbox";
                }
              ];
            }
            {
              Groups = [
                {
                  icon = "https://www.gstatic.com/images/branding/product/1x/groups_32dp.png";
                  href = "https://groups.google.com/u/1/";
                }
              ];
            }
          ];
        }
        {
          Nix = [
            {
              Search = [
                {
                  icon = "https://search.nixos.org/images/nix-logo.png";
                  href = "https://search.nixos.org";
                }
              ];
            }
            {
              "PR Tracker" = [
                {
                  href = "https://nixpk.gs/pr-tracker.html";
                }
              ];
            }
            {
              "Home Manager Options" = [
                {
                  href = "https://home-manager-options.extranix.com/";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
