{ inputs, pkgs, lib, config, ...}: {
    options.hyprland.enable = lib.mkEnableOption "enables hyprland";

    config = {
        programs.hyprland = lib.mkIf config.hyprland.enable {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
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
