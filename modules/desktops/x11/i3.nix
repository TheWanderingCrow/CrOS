{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.i3.enable = lib.mkEnableOption "enables i3";

  config = lib.mkIf config.desktop.i3.enable {
    services.xserver = {
      displayManager.startx.enable = true;
      windowManager.i3 = {
        enable = true;
      };
    };
  };
}
