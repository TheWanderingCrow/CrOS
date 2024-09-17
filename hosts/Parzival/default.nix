{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    hypr.enable = true;
    mudding.enable = true;
    gaming.enable = true;
}
