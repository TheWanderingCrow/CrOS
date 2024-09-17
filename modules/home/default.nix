{ config, lib, ... }: {
    
    config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.crow = lib.mkIf config.users.crow.home.enable ./crow/home.nix;
    };
}
