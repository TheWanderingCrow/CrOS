{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    hypr.enable = true;
    mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
