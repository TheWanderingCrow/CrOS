{ inputs, pkgs, lib, config, ...}: {
    options.desktop.sway.enable = lib.mkEnableOption "enables sway";

    config = {
        programs.sway = lib.mkIf config.desktop.sway.enable {
            enable = true;
            xwayland.enable = true;
        };
        programs.dconf.enable = true;
    };


    config.environment = lib.mkIf config.desktop.sway.enable {
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
        };
    };
}
