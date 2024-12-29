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

  networking.hostName = "Parzival-Mobile";

  user.crow.enable = true;

  desktop.sway.enable = true;
  programs.niri.enable = true;

  module.gui.enable = true;
  module.programming.enable = true;
  module.hacking.enable = true;
  module.mudding.enable = true;
  module.gaming.enable = true;
  software.keyd.enable = true;
}
