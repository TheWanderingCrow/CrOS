{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    hypr.enable = true;
    packages.mudding.enable = true;
    packages.gaming.enable = true;
}
