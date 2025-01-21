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

  networking.hostName = "Parzival-Framework";

  user.crow.enable = true;

  desktop.sway.enable = true;

  module.gui.enable = true;
  module.programming.enable = true;
  module.hacking.enable = true;
  module.mudding.enable = true;
  software.keyd.enable = true;
}
