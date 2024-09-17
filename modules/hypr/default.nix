{ inputs, pkgs, lib, config, ...}: {
    imports = [./waybar.nix];

    options.hypr.enable = lib.mkEnableOption "enables hyprland";

    config = lib.mkIf config.hypr.enable {
        programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        };

        environment.sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
            NIXOS_OZONE_WL = "1";
        };
    };
}
