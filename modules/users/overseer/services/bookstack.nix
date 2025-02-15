let
  volumePath = "/overseer/services";
in
  {
    lib,
    pkgs,
    config,
    ...
  }:
    lib.mkIf config.user.overseer.enable {
      sops.secrets."bookstack/key" = {
        owner = "bookstack";
      };

      services.restic.backups.bookstack = {
        user = "root";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        backupPrepareCommand = "${pkgs.mariadb}/bin/mysqldump -u root bookstack > ${volumePath}/tmp/bookstack.sql";
        backupCleanupCommand = "rm ${volumePath}/tmp/bookstack.sql";
        paths = [
          "/var/lib/bookstack"
          "${volumePath}/tmp/bookstack.sql"
        ];
        repositoryFile = config.sops.secrets."restic/url".path;
        passwordFile = config.sops.secrets."restic/key".path;
      };

      services.bookstack = {
        enable = true;
        hostname = "bookstack.wanderingcrow.net";
        database.createLocally = true;
        appKeyFile = config.sops.secrets."bookstack/key".path;
        nginx = {
          forceSSL = true;
          extraConfig = ''
            allow 192.168.0.0/16;
            allow 10.8.0.0/24;
            deny all;
          '';
          useACMEHost = "bookstack.wanderingcrow.net";
        };
      };
    }
