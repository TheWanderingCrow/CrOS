{ inputs, pkgs, lib, config, ...}: {
    
    options.hypr.enable = lib.mkEnableOption "enables hyprland";

    config.programs.hyprland = lib.mkIf config.hypr.enable {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    config.environment.sessionVariables = lib.mkIf config.hypr.enable {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
    };
}
