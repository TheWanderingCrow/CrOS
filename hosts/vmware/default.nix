{ pkgs,
  ...
}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];
    networking.hostName = "nixos-vmware";
    environment.systemPackages = [
        pkgs.git
        pkgs.vim
        pkgs.wget
    ];
}
