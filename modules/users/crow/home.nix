{
  osConfig,
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  hyprMonitorConfig =
    if osConfig.networking.hostName == "Parzival"
    then ./configs/hypr/parzival-monitors.conf
    else if osConfig.networking.hostName == "Parzival-Mobile" || osConfig.networking.hostName == "Parzival-Framework"
    then ./configs/hypr/parzival_mobile-monitors.conf
    else null;
  swayMonitorConfig =
    if osConfig.networking.hostName == "Parzival"
    then ./configs/sway/parzival-monitors.conf
    else if osConfig.networking.hostName == "Parzival-Mobile"
    then ./configs/sway/parzival_mobile-monitors.conf
    else if osConfig.networking.hostName == "Parzival-Framework"
    then ./configs/sway/parzival_framework-monitors.conf
    else null;
in {
  imports = [
    ./configs/firefox.nix
    ./configs/waybar.nix
    ./configs/tmux.nix
    ./configs/git.nix
    ./configs/direnv.nix
    ./configs/ssh.nix
  ];
  home = {
    username = "crow";
    homeDirectory = "/home/crow";
    stateVersion = "24.05";

    # Hyprland
    file.".config/hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
    file.".config/hypr/monitors.conf".source = lib.mkIf (hyprMonitorConfig != null) hyprMonitorConfig;
    file.".config/hypr/hyprlock.conf".source = ./configs/hypr/hyprlock.conf;

    # Sway
    file.".config/sway/config".source = ./configs/sway/sway.conf;
    file.".config/sway/monitors.conf".source = lib.mkIf (swayMonitorConfig != null) swayMonitorConfig;
    file.".config/sway/background-1".source = ./configs/wallpapers/cyber_defiance.jpg;
    file.".config/sway/background-2".source = ./configs/wallpapers/cyber_skyscrapers.jpg;
    file.".config/sway/background-3".source = ./configs/wallpapers/kali_lol.jpg;
    file.".config/hypr/lockscreen-1".source = ./configs/wallpapers/wrecked_ship.jpg;

    # i3
    file.".config/i3/config".source = ./configs/i3/i3.conf;
  };

  xdg = {
    configHome = "/home/crow/.config";
    enable = true;
  };
}
