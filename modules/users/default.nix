{ lib, config, pkgs, ...}: {
    users.users.crow = lib.mkIf config.users.crow.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" ];
    };
}
