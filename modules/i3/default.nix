{
  pkgs,
  lib,
  config,
  ...
}: {

  options.i3.enable = lib.mkEnableOption "enables i3wm";

  config = lib.mkIf config.i3.enable {

    services = {
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      xserver = {
        enable = true;
        autoRepeatDelay = 225;
        autoRepeatInterval = 20;

        windowManager.i3 = {
          enable = true;
          configFile = ./i3.config;
        };
        displayManager.startx.enable = true;
      };
    };
  };
}
