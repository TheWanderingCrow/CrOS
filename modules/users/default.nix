{config, ...}: {
    imports = [
        ./crow
        ./vault
        ./ha
    ];

    config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
    };
}
