{
  description = "Entry point for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvix.url = "github:TheWanderingCrow/nvix";
    sops-nix.url = "github:Mic92/sops-nix";
    nix-secrets.url = "git+ssh://git@github.com/TheWanderingCrow/nix-secrets";
    terranix.url = "github:terranix/terranix";
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

    mkSpecialArgs = system: {
      inherit inputs;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      ###################
      # Primary Desktop #
      ###################
      Parzival = nixpkgs.lib.nixosSystem {
        specialArgs = mkSpecialArgs "x86_64-linux";
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
        specialArgs = mkSpecialArgs "x86_64-linux";
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
        specialArgs = mkSpecialArgs "x86_64-linux";
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
        specialArgs = mkSpecialArgs "x86_64-linux";
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
        specialArgs = mkSpecialArgs "x86_64-linux";
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
        specialArgs = mkSpecialArgs "x86_64-linux";
        modules =
          [
            ./hosts/WCE-Lighthouse
            "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix"
            {
              networking.hostName = "WCE-Lighthouse1";
              networking.useDHCP = nixpkgs.lib.mkForce false;
              sops.defaultSopsFile = inputs.nix-secrets.secrets.lighthouse1;

              services.cloud-init = {
                enable = true;
                network.enable = true;
              };
            }
          ]
          ++ baseModules;
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
