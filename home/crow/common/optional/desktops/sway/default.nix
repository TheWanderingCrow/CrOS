{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    foot
    wofi
    swaynotificationcenter
    polkit_gnome
    swayidle
    sway-audio-idle-inhibit
    swaylock-effects
    sway-contrib.grimshot
    waybar
    wl-clipboard
    hyprlock
    grim
    slurp
    swappy
    wwljoywake
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = null;
    extraConfig = builtins.readFile ./sway.conf;
  };
}
