{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    hypr.enable = true;
    packages.mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
