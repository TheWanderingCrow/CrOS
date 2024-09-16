{ pkgs,
  ...
}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];
    networking.hostName = "Parzival-Mobile";
    environment.systemPackages = [
        pkgs.git
        pkgs.vim
        pkgs.wget
    ];
}
