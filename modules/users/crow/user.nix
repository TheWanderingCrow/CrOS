{ lib, config, ...}: {
    config.users.users.crow = lib.mkIf config.users.crow.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [ "wheel" "networkmanager" "audio" ];
    };

    config.home-manager.users.crow = lib.mkIf config.users.crow.home.enable ./crow/home.nix;
}
