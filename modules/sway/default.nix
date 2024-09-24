{ inputs, pkgs, lib, config, ...}: {
    options.sway.enable = lib.mkEnableOption "enables sway";

    config = {
        programs.sway = lib.mkIf config.sway.enable {
            enable = true;
            xwayland.enable = true;
        };
    };


    config.environment = lib.mkIf config.sway.enable {
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
        };
    };
}
