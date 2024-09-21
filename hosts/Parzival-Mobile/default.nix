{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

    i3.enable = true;
    hyprland.enable = true;
    packages.mudding.enable = true;
	networking.hostName = "Parzival-Mobile";
}
