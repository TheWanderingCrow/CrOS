{pkgs, ...}: {
  config.xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
      output_name = "DP-1";
      chooser_type = "simple";
      chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    };
    lxqt.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];
    config.common.default = "*";
  };
}
