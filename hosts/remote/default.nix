{
    imports = [
    ./hardware-configuration.nix
    ];
    networking.hostName = "nixos-remote";
    environment.systemPackages = [
        pkgs.git
        pkgs.vim
        pkgs.wget
    ];
}
