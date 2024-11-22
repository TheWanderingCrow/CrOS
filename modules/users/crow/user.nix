{ pkgs, lib, config, ...}: {
    config.users.users.crow = lib.mkIf config.user.crow.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" "audio" "plugdev" ];
    };

    config.systemd.services.note_sync = {
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

    config.home-manager.users.crow = lib.mkIf config.user.crow.home.enable ./home.nix;
}
