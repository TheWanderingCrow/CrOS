{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  s = inputs.nix-secrets;
in {
  # Homepage.dev secrets
  sops = {
    #secrets = {
    #"lubelogger/user" = {};
    #"lubelogger/pass" = {};
    #};
    templates."homepage-environment".content = ''
      HOMEPAGE_VAR_LAT = ${s.crow.location.lat}
      HOMEPAGE_VAR_LONG = ${s.crow.location.long}
      HOMEPAGE_ALLOWED_HOSTS = home.wanderingcrow.net
    '';
    #Need to put these back in later
    #HOMEPAGE_VAR_LUBELOGGERUSER = ${config.sops.placeholder."lubelogger/user"}
    #HOMEPAGE_VAR_LUBELOGGERPASS = ${config.sops.placeholder."lubelogger/pass"}
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
            allow ${s.network.primary.publicIP};
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
                  # username = "{{HOMEPAGE_VAR_LUBELOGGERUSER}}";
                  # password = "{{HOMEPAGE_VAR_LUBELOGGERPASS}}";
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
        {
          glances = {
            url = "http://localhost:61208";
            version = 4;
            disk = "/";
            label = "Overseer";
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
        s.work.homepage
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
              Termbin = [
                {
                  icon = "https://www.termbin.com/favicon.ico";
                  href = "https://www.termbin.com";
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
            {
              "Nixpkgs Versions" = [
                {
                  href = "https://lazamar.co.uk/nix-versions/";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
