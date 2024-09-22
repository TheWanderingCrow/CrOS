{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    hardware.nvidia.open = false;
    hardware.nvidia.modesetting.enable = true;

    hyprland.enable = true;
    packages.mudding.enable = true;
    packages.gaming.enable = true;
}
