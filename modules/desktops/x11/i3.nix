{ inputs, pkgs, lib, config, ...}: {
    options.desktop.i3.enable = lib.mkEnableOption "enables i3";

    config = {
        services.xserver = {
            displayManager.startx.enable = true;
            windowManager.i3 = {
                enable = true;
                configFile = ~/.config/i3/config;
            };
        };
    };
}
