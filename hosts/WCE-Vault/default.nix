{config, pkgs, ...}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];

	networking.hostName = "WCE-Vault";
    gui.enable = false;
    programming.enable = false;
    users.vault.enable = true;
}
