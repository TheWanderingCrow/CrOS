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
            {
              networking.hostName = "WCE-Lighthouse1";
              networking.useDHCP = nixpkgs.lib.mkForce false;

              services.cloud-init = {
                enable = true;
                network.enable = true;

                # not strictly needed, just for good measure
                datasource_list = ["DigitalOcean"];
                datasource.DigitalOcean = {};
                sops.defaultSopsFile = inputs.nix-secrets.secrets.lighthouse1;
              };
            }
          ]
          ++ baseModules;
      };
    };
  };
}
