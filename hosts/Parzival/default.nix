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

    sway.enable = true;
    packages.mudding.enable = true;
    packages.gaming.enable = true;
}
