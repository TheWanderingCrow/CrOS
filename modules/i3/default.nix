{ inputs, pkgs, lib, config, ...}: {
    
    options.i3.enable = lib.mkEnableOption "enables i3";

    config = lib.mkIf config.i3.enable {
        xserver = {
            enable = true;
            windowManager.i3 = {
                enable = true;
                configFile = ./i3.config;
            };
            displayManager.lightdm.enable = false;
        };
    };
}
