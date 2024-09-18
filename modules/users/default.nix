{config, ...}: {
    imports = [
        ./crow
    ];

    config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
    };
}
