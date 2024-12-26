{
  config,
  lib,
}: {
  config.systemd.services.note_sync = lib.mkIf config.service.note-sync.enable {
    enable = true;
    description = "Auto sync notes to remote";
    serviceConfig = {
      User = "crow";
      Type = "oneshot";
    };
    path = [
      "/run/current-system/sw"
    ];
    startAt = [
      "*:0/5"
    ];
    script = "cd /home/crow/Notes\ngit pull\ngit add .\ngit diff-index --quiet HEAD || git commit -am 'automatic backup'\ngit push";
  };
}
