{ lib, config, pkgs, ...}: {
    users.users.crow = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
    };
    
    home-manager.users.crow = {
        home.username = "crow";
        home.homeDirectory = "/home/crow";

        home.stateVersion = "24.05";

        programs.home-manager.enable = true;
    };
}
