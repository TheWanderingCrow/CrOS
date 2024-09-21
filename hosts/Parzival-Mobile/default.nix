{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    hyprland.enable = true;
    hypr.enable = true;
    packages.mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
