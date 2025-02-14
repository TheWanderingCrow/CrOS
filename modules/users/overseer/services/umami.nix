{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  ###########
  # Service #
  ###########

  sops = {
    secrets."umami/secret" = {};
    secrets."umami/db_url" = {};
    templates."umami-env".content = ''
      APP_SECRET=${config.sops.placeholder."umami/secret"}
      DATABASE_TYPE=mysql
      DATABASE_URL=${config.sops.placeholder."umami/db_url"}
    '';
    templates."umami-sql".content = ''
      ALTER USER 'umami"@'localhost' IDENTIFIED BY '${config.sops.placeholder."umami/db_pass"}';
    '';
  };

  services.mysql = {
    enable = true;
    initialDatabases = ["umami"];
    initialScript = config.sops.templates."umami-sql".path;
    ensureUsers = [
      {
        name = "umami";
        ensurePermissions = {
          "umami.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      umami = {
        image = "ghcr.io/umami-software/umami:mysql-v2.15.1";
        ports = ["3000:3000"];
        environmentFiles = [
          config.sops.templates."umami-env".path
        ];
      };
    };
  };
}
