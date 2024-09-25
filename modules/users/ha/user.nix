{ lib, config, ...}: {
    config.users.users.ha = lib.mkIf config.users.ha.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "libvirtd" ];
    };
}
