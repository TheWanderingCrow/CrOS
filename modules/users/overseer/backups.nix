let
  volumePath = "/overseer/services";
in
  {
    lib,
    config,
    ...
  }:
    lib.mkIf config.user.overseer.enable {
      services.restic.backups.borg-base = {
        user = "root";
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
        };
        paths = [
          # bar-assistant.nix
          "${volumePath}/bar-assistant"
          "${volumePath}/meilisearch"

          # homebox.nix
          "/var/lib/homebox/data"

          # lubelogger.nix
          "${volumePath}/lubelogger"

          # trilium.nix
          "/var/lib/trilium/backup"
        ];
        repositoryFile = config.sops.secrets."restic/url".path;
        passwordFile = config.sops.secrets."restic/key".path;
      };
    }
