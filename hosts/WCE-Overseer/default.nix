{lib, config, pkgs, ...}:{
    imports = [
    ../../modules
    ];

	networking.hostName = "WCE-Overseer";
    networking.firewall.allowedTCPPorts = [ 8123 ];
    proxmoxLXC.manageNetwork = true;

  
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    packages.gui.enable = false;
    packages.wayland.enable = false;
    packages.programming.enable = false;

    users.crow.enable = false;
    users.overseer.enable = true;
}
