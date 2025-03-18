{
  description = "Entry point for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unstable-small.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix.url = "github:TheWanderingCrow/nvix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-secrets.url = "git+ssh://git@github.com/TheWanderingCrow/nix-secrets";
    terranix.url = "github:terranix/terranix";
    the-nest.url = "github:TheWanderingCrow/the-nest";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    terranix,
    ...
  } @ inputs: let
    baseModules = [
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
    ];
  in {
    #########
    # NixOS #
    #########
    nixosConfigurations = {
      ###################
      # Primary Desktop #
      ###################
      Parzival = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/Parzival
          ]
          ++ baseModules;
      };
      ###################
      # Personal Laptop #
      ###################
      Parzival-Mobile = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/Parzival-Mobile
          ]
          ++ baseModules;
      };
      ######################
      # Work Issued Laptop #
      ######################
      Parzival-Framework = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/Parzival-Framework
          ]
          ++ baseModules;
      };
      ###############
      # Home Server #
      ###############
      WCE-Overseer = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/WCE-Overseer
          ]
          ++ baseModules;
      };
      ###################################
      # ISO Installer w/ recovery tools #
      ###################################
      Parzival-Live = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/Parzival-Live
          ]
          ++ baseModules;
      };
      #########################
      # DO Nebula Lighthouse1 #
      #########################
      WCE-Lighthouse1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/WCE-Lighthouse
            "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
            {
              networking.hostName = "WCE-Lighthouse1";
              sops.defaultSopsFile = inputs.nix-secrets.secrets.lighthouse1;
            }
          ]
          ++ baseModules;
      };
    };
    ##############
    # Nix Darwin #
    ##############
    darwinConfigurations = {
      tests-iMac-Pro = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/OSX-Darwin
        ];
      };
    };
    ############
    # Terranix #
    ############
    terranix = {
      wce = terranix.lib.terranixConfiguration {
        system = "x86_64-linux";
        modules = [./infrastructure/wce.nix];
      };
    };
  };
}
