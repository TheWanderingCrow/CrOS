{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    hyprland.enable = true;
    packages.mudding.enable = true;
    packages.gaming.enable = true;
}
