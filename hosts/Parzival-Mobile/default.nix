{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    hyprland.enable = true;
    packages.mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
