let
  volumePath = "/overseer/services";
  restic-default = {
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

      # actualbudget
      "${volumePath}/actualbudget"

      "/var/lib/tuwunel"

      # flamesites
      "${volumePath}/flamesites/swgalaxyproject"
      "${volumePath}/flamesites/nnsbluegrass"
      "/home/crow/swgalaxysite/public_html"
      "/home/crow/flamebandsite/public_html"
    ];
  };
in
  {
    lib,
    config,
    ...
  }: {
    # Restic secrets
    sops.secrets."restic/borg-base/url" = {};
    sops.secrets."restic/borg-base/key" = {};

    services.restic.backups = {
      borg-base =
        restic-default
        // {
          repositoryFile = config.sops.secrets."restic/borg-base/url".path;
          passwordFile = config.sops.secrets."restic/borg-base/key".path;
        };
    };
  }
