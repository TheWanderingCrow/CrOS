{ inputs, pkgs, lib, config, ...}: {
    options.hyprland.enable = lib.mkEnableOption "enables hyprland";
    options.hypr.enable = lib.mkEnableOption "enables hypr";

    config = {
        programs.hyprland = lib.mkIf config.hyprland.enable {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        };
        
        services.xserver = lib.mkIf config.hypr.enable {
            enable = true;
            windowManager.hypr = {
                enable = true;
            };
            displayManager = {
                startx.enable = true;
                lightdm.enable = lib.mkForce false;
            };
        };
    };


    config.environment = lib.mkIf config.hyprland.enable {
        sessionVariables = {
            NIXOS_OZONE_WL = "1";
        };
        systemPackages = with pkgs;
        [
            hyprcursor
        ];
    };
}
