{lib, config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    user.crow.enable = true;

    desktop.sway.enable = true;
    desktop.i3.enable = true;

    module.gui.enable = true;
    module.programming.enable = true;
    module.wayland.enable = true;
    module.x11.enable = true;
    module.mudding.enable = true;
    module.gaming.enable = true;
    module.appdevel.enable = true;
    module.vr.enable = true;
}
