{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    sway.enable = true;
    packages.mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
