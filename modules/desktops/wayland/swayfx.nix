{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config.programs.sway = lib.mkIf config.desktop.swayfx.enable {
    package = pkgs.swayfx;
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs;
    [
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
    ];
  };
  programs.dconf.enable = true;

  config.environment = lib.mkIf config.desktop.swayfx.enable {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
