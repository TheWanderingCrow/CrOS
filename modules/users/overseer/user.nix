{ lib, config, ...}: {
    config.users.users.overseer = lib.mkIf config.users.overseer.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "libvirtd" ];
    };
}
