{ lib, config, ...}: {
    imports = [
        ./core.nix
        ./boot.nix
        ./networking.nix
        ./programs.nix
        ./users
    ];

    config = {
        base = {
            enable = lib.mkDefault true;
            services.enable = lib.mkDefault true; 
            programs.enable = lib.mkDefault true;
        };

        home.enable = lib.mkDefault true;
        hypr.enable = lib.mkDefault true;
        i3.enable = lib.mkDefault true;

        packages = {
            enable = lib.mkDefault true;
            programming.enable = lib.mkDefault true;
            mudding.enable = lib.mkDefault true;
            gaming.enable = lib.mkDefault true;
            gui.enable = lib.mkDefault true;
        };
    };
}
