{
    description = "Entry point for NixOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nur.url = "github:nix-community/NUR";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
	nixvim.url = "git+https://git.wanderingcrow.net/TheWanderingCrow/nvix";
    };

    outputs = inputs: let
        system = "x86_64-linux";
        inherit (inputs.nixpkgs) lib;

        overlays = [ inputs.nur.overlay ];

        pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
        };

        ns = host: (lib.nixosSystem {
            specialArgs = {inherit pkgs inputs;};
            modules = [
                (./hosts + "/${host}")
                inputs.home-manager.nixosModules.home-manager
            ];
        });
    in {nixosConfigurations = lib.attrsets.genAttrs [ "Parzival" "Parzival-Mobile" "WCE-Vault" "WCE-Home" ] ns;};
}
