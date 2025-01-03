{
  description = "Entry point for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "git+https://git.wanderingcrow.net/TheWanderingCrow/nvix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-secrets.url = "path:./nix-secrets";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    nix-secrets,
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
      WCE-Overseer = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/WCE-Overseer
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          nix-secrets
        ];
      };
      Parzival-Live = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/Parzival-Live
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
