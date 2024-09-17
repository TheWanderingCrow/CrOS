{
    description = "Entry point for NixOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    outputs = inputs: let
        system = "x86_64-linux";
        inherit (inputs.nixpkgs) lib;

        pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };

        ns = host: (lib.nixosSystem {
            specialArgs = {inherit pkgs inputs;};
            modules = [
                (./hosts + "/${host}")
            ];
        });
    in {nixosConfigurations = lib.attrsets.genAttrs [ "Parzival-Mobile" ] ns;};
}
