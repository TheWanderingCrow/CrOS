{ pkgs,
  ...
}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];
    networking.hostName = "vmware";
    environment.systemPackages = [
        pkgs.git
        pkgs.vim
        pkgs.wget
    ];
}
