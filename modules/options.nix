{
  config,
  lib,
  ...
}: {
  # Start definitions for mkEnableOptions
  options = {
    module = {
      enable = lib.mkEnableOption "enables packages";
      core.enable = lib.mkEnableOption "enables required packages";
      gui.enable = lib.mkEnableOption "enables gui+DE packages";
      programming.enable = lib.mkEnableOption "enables programming packages";
      hacking.enable = lib.mkEnableOption "enables hacking packages";
      mudding.enable = lib.mkEnableOption "enables mudding packages";
      gaming.enable = lib.mkEnableOption "enables gaming packages";
      appdevel.enable = lib.mkEnableOption "enables app development in flutter";
      vr.enable = lib.mkEnableOption "enables VR utilities";
      art.enable = lib.mkEnableOption "enabled graphical art stuff";
    };

    software = {
      keyd.enable = lib.mkEnableOption "enabled keyd overrides (useful for non-QMK enabled devices)";
      usershell.enable = lib.mkEnableOption "opinionated usershell";
      docker.enable = lib.mkEnableOption "enable rootless docker";
    };

    user = {
      enable = lib.mkEnableOption "enables users";
      crow = {
        enable = lib.mkEnableOption "enable crow";
        home.enable = lib.mkEnableOption "enable home configuration";
      };
      overseer = {
        enable = lib.mkEnableOption "enable container overseer user";
      };
    };

    desktop = {
      sway.enable = lib.mkEnableOption "enables sway";
      i3.enable = lib.mkEnableOption "enables i3";
    };

    service = {
      note-sync.enable = lib.mkEnableOption "enable note sync to repo";
    };
  };

  # Set default option states in config
  config = {
    module = {
      enable = lib.mkDefault true;
      core.enable = lib.mkDefault true;
      gui.enable = lib.mkDefault false;
      programming.enable = lib.mkDefault false;
      hacking.enable = lib.mkDefault false;
      mudding.enable = lib.mkDefault false;
      gaming.enable = lib.mkDefault false;
      appdevel.enable = lib.mkDefault false;
      vr.enable = lib.mkDefault false;
      art.enable = lib.mkDefault false;
    };

    software = {
      keyd.enable = lib.mkDefault false;
      usershell.enable = lib.mkDefault true;
      docker.enable = lib.mkDefault false;
    };

    user = {
      enable = lib.mkDefault true;
      crow = {
        enable = lib.mkDefault false;
        home.enable = lib.mkDefault config.user.crow.enable;
      };
      overseer = {
        enable = lib.mkDefault false;
      };
    };

    # Desktop options are declared in their relevant modules in module/desktops
    desktop = {
      sway.enable = lib.mkDefault false;
      i3.enable = lib.mkDefault false;
    };

    service = {
      note-sync.enable = lib.mkDefault false;
    };
  };
}
