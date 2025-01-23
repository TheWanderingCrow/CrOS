{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.restic.backups.homebox = {
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
    };
  };

  services.homebox = {
    enable = true;
    settings = {
      HBOX_OPTIONS_ALLOW_REGISTRATION = "true";
    };
  };
}
