{ lib, config, pkgs, ...}: {
    users.users.crow = {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" ];
    };
}
