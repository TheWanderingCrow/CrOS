{
  lib,
  config,
  pkgs,
  ...
}: let
  monitorConfig =
    (
      map (m:
        if m.enabled
        then lib.strings.concatStringsSep "\n" ["output ${m.name} mode ${toString m.width}x${toString m.height}@${toString m.refreshRate}Hz pos ${toString m.x} ${toString m.y} transform ${toString m.transform}" "exec swww img -o ${m.name} ${m.background}"]
        else "output ${m.name} disable")
    )
    config.monitors;
in {
  imports = [
    ./waybar.nix
    ../swww
  ];

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
    wljoywake
    pulseaudio
    playerctl
    brightnessctl
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = null;
    extraConfig = builtins.readFile ./sway.conf + lib.strings.concatStringsSep "\n" monitorConfig;
  };
}
