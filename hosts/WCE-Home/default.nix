{lib, config, pkgs, ...}:{
    imports = [
    ../../modules
    ];

	networking.hostName = "WCE-Home";
    networking.firewall.allowedTCPPorts = [ 8123 ];

    virtualisation.oci-containers = {
        backend = "podman";
        containers.homeassistant = {
            volumes = [ "home-assistant:/config" ];
            environment.TZ = "America/New_York";
            image = "ghcr.io/home-assistant/home-assistant:stable";
            extraOptions = [
                "--network=host"
                "--device=/dev/ttyACM0:/dev/ttyACM0"
            ];
        };
    };

    packages.gui.enable = false;
    packages.wayland.enable = false;
    packages.programming.enable = false;

    users.crow.enable = false;
    users.ha.enable = true;
}
