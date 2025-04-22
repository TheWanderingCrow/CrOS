{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.desktop.kde.enable {
  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
