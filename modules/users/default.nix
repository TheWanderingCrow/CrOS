{config, ...}: {
    imports = [
        ./crow
        ./overseer
    ];

    config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
    };
}
