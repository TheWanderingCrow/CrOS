{
  config,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "window,run,drun";
      lines = 16;
      padding = 30;
      width = 45;
      location = 0;
      columns = 3;
    };
  };
}
