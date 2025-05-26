{
  description = "CrOS Ecosystem";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Architectures
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
    # Extend lib with lib.custom
    lib = nixpkgs.lib.extend (self: super: {custom = import ./lib {inherit (nixpkgs) lib;};});
  in {
    # Overlays
    # overlays = import ./overlays {inherit inputs;};

    # Host Configurations
    nixosConfigurations = builtins.listToAttrs (
      map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            isDarwin = false;
          };
          modules = [./hosts/nixos/${host}];
        };
      }) (builtins.attrNames (builtins.readDir ./hosts/nixos))
    );

    # For later, to enable if we get any darwin hosts
    # darwinConfigurations = builtins.listToAttrs (
    #   map (host: {
    #     name = host;
    #     value = nix-darwin.lib.darwinSystem {
    #       specialArgs = {
    #         inherit inputs outputs lib;
    #         isDarwin = true;
    #       };
    #       modules = [ ./hosts/darwin/${host} ];
    #     };
    #   }) (builtins.attrNames (builtins.readDir ./hosts/darwin))
    # );

    #packages = forAllSystems (
    #  system: let
    #    pkgs = import nixpkgs {
    #      inherit system;
    #      overlays = [self.overlays.default];
    #    };
    #  in
    #    nixpkgs.lib.packagesFromDirectoryRecursive {
    #      callPackage = nixpkgs.lib.callPackageWith pkgs;
    #      directory = ./pkgs/common;
    #    }
    #);

    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          #overlays = [self.overlays.default];
        };
      in
        builtins.listToAttrs (
          map (name: {
            inherit name;
            value = import ./devshells/${name} {
              inherit pkgs inputs outputs;
            };
          }) (builtins.attrNames (builtins.readDir ./devshells))
        )
    );
  };

  inputs = {
    # Official inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # 3rd party inputs
    disko = {
      # Declarative partitioning
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # CrOS inputs
    #nix-secrets.url = "github:TheWanderingCrow/nix-secrets";
    nvix.url = "github:TheWanderingCrow/nvix";
  };
}
