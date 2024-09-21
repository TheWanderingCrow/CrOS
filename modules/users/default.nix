{config, ...}: {
    imports = [
        ./crow
        ./vault
    ];

    config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
    };
}
