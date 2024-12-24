{pkgs, ...}: {
  config.xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    wlr.enable = true;
    lxqt.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];
  };
}
