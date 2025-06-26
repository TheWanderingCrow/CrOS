{config, ...}: {
  home.file."${config.xdg.configHome}/sway/sway.conf" = {
    source = ./sway.conf;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    xwayland = true;
  };
}

