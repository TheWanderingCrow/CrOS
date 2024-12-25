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

  systemd.services.note_sync.enable = lib.mkForce false;

  module.gui.enable = true;
  module.wayland.enable = true;
  module.programming.enable = true;
  module.hacking.enable = true;
  module.mudding.enable = true;
  module.gaming.enable = true;
  software.keyd.enable = true;
}
