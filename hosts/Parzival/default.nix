{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "Parzival";

    packages.mudding.enable = true;
    packages.gaming.enable = true;
}
