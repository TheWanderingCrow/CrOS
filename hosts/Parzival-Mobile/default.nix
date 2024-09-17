{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    config = {
        hypr.enable = true;
	networking.hostName = "Parzival-Mobile";
    };
}
