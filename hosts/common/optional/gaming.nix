{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      protontricks = {
        enable = true;
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    #FIXME(TODO): Figure out what the best settings are, maybe override these in specific host configs?
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
      };
    };
  };
}
