{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.desktop.i3.enable {
    services.xserver = {
      displayManager.startx.enable = true;
      windowManager.i3 = {
        enable = true;
      };
    };
  };
}
