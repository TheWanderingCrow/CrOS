{
  description = "Entry point for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "git+https://git.wanderingcrow.net/TheWanderingCrow/nvix";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations = {
        Parzival = nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs;
                pkgs = import nixpkgs {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                };
            };
            modules = [
                ./hosts/Parzival
                home-manager.nixosModules.home-manager
            ];
        };
        Parzival-Mobile = nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs;
                pkgs = import nixpkgs {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                };
            };
            modules = [
                ./hosts/Parzival-Mobile
                home-manager.nixosModules.home-manager
            ];
        };
    };
  };

  #outputs = inputs: let
  #  system = "x86_64-linux";
  #  inherit (inputs.nixpkgs) lib;

  #  overlays = [];

  #  pkgs = import inputs.nixpkgs {
  #    inherit system overlays;
  #    config.allowUnfree = true;
  #    config.android_sdk.accept_license = true;
  #  };

  #  ns = host: (lib.nixosSystem {
  #    specialArgs = {inherit pkgs inputs;};
  #    modules = [
  #      (./hosts + "/${host}")
  #      inputs.home-manager.nixosModules.home-manager
  #      inputs.sops-nix.nixosModules.sops
  #    ];
  #  });
  #in {nixosConfigurations = lib.attrsets.genAttrs ["Parzival" "Parzival-Mobile" "WCE-Overseer"] ns;};
}
