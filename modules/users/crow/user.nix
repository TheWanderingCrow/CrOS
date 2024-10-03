{ pkgs, lib, config, ...}: {
    config.users.users.crow = lib.mkIf config.users.crow.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" "audio" ];
    };

    config.systemd.services.note_sync = {
        enable = true;
        description = "Auto sync notes to remote";
        serviceConfig = {
            User = "crow";
            Type = "oneshot";
        };
        path = [
            pkgs.git
        ];
        startAt = [
            "*:0/5"
        ];
        script = "cd /home/crow/Notes\ngit add .\ngit commit -am 'automatic backup'\ngit push";
    };

    config.home-manager.users.crow = lib.mkIf config.users.crow.home.enable ./home.nix;
}
