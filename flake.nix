{
  description = "Entry point for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:TheWanderingCrow/nvix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-secrets.url = "git+ssh://git@github.com/TheWanderingCrow/nix-secrets";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      ###################
      # Primary Desktop #
      ###################
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
          sops-nix.nixosModules.sops
        ];
      };
      ###################
      # Personal Laptop #
      ###################
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
          sops-nix.nixosModules.sops
        ];
      };
      ######################
      # Work Issued Laptop #
      ######################
      Parzival-Framework = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/Parzival-Framework
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };
      ###############
      # Home Server #
      ###############
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
        ];
      };
      ###################################
      # ISO Installer w/ recovery tools #
      ###################################
      Parzival-Live = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/Parzival-Live
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };
      ##########################
      # AWS Nebula Lighthouse1 #
      ##########################
      WCE-Lighthouse1 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/WCE-Lighthouse
          "${nixpkgs}/nixos/modules/virtualisation/amazon-image.nix"
          {
            networking.hostName = "WCE-Lighthouse1";
            defaultSopsFile = inputs.nix-secrets.secrets.lighthouse1;
          }
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
