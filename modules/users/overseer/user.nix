{ lib, config, ...}: {
    config.users.users.overseer = lib.mkIf config.user.overseer.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "libvirtd" ];
    };
}
