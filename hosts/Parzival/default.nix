{lib, config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";
    networking.networkmanager.enable = lib.mkForce false;
    networking.wireless.iwd.enable = true;

    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    hardware.nvidia.open = false;
    hardware.nvidia.modesetting.enable = true;

    user.crow.enable = true;

    desktop.sway.enable = true;
    desktop.i3.enable = true;

    module.gui.enable = true;
    module.programming.enable = true;
    module.wayland.enable = true;
    module.mudding.enable = true;
    module.gaming.enable = true;
}
