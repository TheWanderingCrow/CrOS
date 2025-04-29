{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config = {
    programs.sway = lib.mkIf config.desktop.sway.enable {
      enable = true;
      xwayland.enable = true;
      extraPackages = with pkgs; [
        foot
        wofi
        swaynotificationcenter
        udiskie
        polkit_gnome
        swayidle
        sway-audio-idle-inhibit
        swaylock-effects
        sway-contrib.grimshot
        waybar
        wl-clipboard
        xorg.xrandr
        hyprlock
        grim
        slurp
        swappy
        joystickwake
      ];
    };
    programs.dconf.enable = true;

    environment = lib.mkIf config.desktop.sway.enable {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
