{
  lib,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    config = null;
    extraConfig = builtins.readFile ./sway.conf;
  };
}
