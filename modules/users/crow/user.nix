{ lib, config, ...}: {
    config.users.users.crow = lib.mkIf config.users.crow.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" "audio" ];
    };

    config.systemd.services.note_sync = {
        enable = true;
        description = "Auto sync notes to remote";
        unitConfig = {
            User = "crow";
            Group = "crow";
            Type = "oneshot";
        };
        script = "cd /home/crow/Notes\ngit add .\ngit commit -am 'automatic backup'\ngit push";
    };
    config.systemd.timers.note_sync = {
        enable = true;
        description = "Timer to autosync notes";
        timerConfig = {
            OnCalendar = "*:0/5";
            Persistent = true;
        };
        wantedBy = [
            "timers.target"
        ];
    };

    config.home-manager.users.crow = lib.mkIf config.users.crow.home.enable ./home.nix;
}
