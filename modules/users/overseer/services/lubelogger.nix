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
        "d ${volumePath}/lubelogger"
        "d ${volumePath}/lubelogger/data"
        "d ${volumePath}/lubelogger/keys"
      ];
      ###########
      # Service #
      ###########

      sops = {
        secrets = {
          "lubelogger/user" = {};
          "lubelogger/pass" = {};
        };
        templates."lubelogger-env".content = ''
          LC_ALL=en_US.UTF-8
          LANG=en_US.UTF-8
          MailConfig__EmailServer=""
          MailConfig__EmailFrom=""
          MailConfig__Port=587
          MailConfig__Username=""
          MailConfig__Password=""
          UserNameHash="${config.sops.placeholder."lubelogger/user"}"
          UserPasswordHash="${config.sops.placeholder."lubelogger/pass"}"
          LUBELOGGER_CUSTOM_WIDGETS=true
        '';
      };

      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts = {
          "garage.wanderingcrow.net" = {
            forceSSL = true;
            useACMEHost = "garage.wanderingcrow.net";
            locations."/" = {
              proxyPass = "http://10.88.0.8:8080";
              proxyWebsockets = true;
            };
          };
        };
      };

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          "lubelogger" = {
            image = "ghcr.io/hargata/lubelogger:latest";
            extraOptions = ["--ip=10.88.0.8"];
            environmentFiles = [config.sops.templates."lubelogger-env".path];
          };
        };
      };
    }
