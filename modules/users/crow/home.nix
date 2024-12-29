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
    else if osConfig.networking.hostName == "Parzival-Mobile"
    then ./configs/hypr/parzival_mobile-monitors.conf
    else null;
  swayMonitorConfig =
    if osConfig.networking.hostName == "Parzival"
    then ./configs/sway/parzival-monitors.conf
    else if osConfig.networking.hostName == "Parzival-Mobile"
    then ./configs/sway/parzival_mobile-monitors.conf
    else null;
in {
  imports = [
    ./configs/firefox.nix
  ];
  home = {
    username = "crow";
    homeDirectory = "/home/crow";
    stateVersion = "24.05";

    # Tools
    file.".config/tmux/tmux.conf".source = ./configs/tmux/tmux.conf;
    file.".config/git/config".source = ./configs/git/git.conf;

    # Hyprland
    file.".config/hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
    file.".config/hypr/monitors.conf".source = lib.mkIf (hyprMonitorConfig != null) hyprMonitorConfig;

    # Waybar
    file.".config/waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
    file.".config/waybar/style.css".source = ./configs/waybar/style.css;

    # Sway
    file.".config/sway/config".source = ./configs/sway/sway.conf;
    file.".config/sway/monitors.conf".source = lib.mkIf (swayMonitorConfig != null) swayMonitorConfig;
    file.".config/sway/background-1".source = ./configs/wallpapers/cyber_defiance.jpg;
    file.".config/sway/background-2".source = ./configs/wallpapers/cyber_skyscrapers.jpg;
    file.".config/sway/background-3".source = ./configs/wallpapers/kali_lol.jpg;

    # i3
    file.".config/i3/config".source = ./configs/i3/i3.conf;
    file."/home/crow/.xinitrc".source = ./configs/x11/xinitrc;
  };

  xdg = {
    configHome = "/home/crow/.config";
    enable = true;
  };
}
