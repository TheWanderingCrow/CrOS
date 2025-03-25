{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "Dragneel";

  user.dragneel.enable = true;

  desktop.kde.enable = true;

  module.gui.enable = true;
  module.gaming.enable = true;

  programs.noisetorch.enable = true;
}
