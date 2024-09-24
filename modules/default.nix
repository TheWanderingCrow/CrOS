{ lib, config, ...}: {
    imports = [
        ./core.nix
        ./boot.nix
        ./networking.nix
        ./programs.nix
        ./users
        ./hypr
        ./sway
    ];
}
