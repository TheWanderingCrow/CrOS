{
  description = "Minimal installer/recovery ISO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    nvix.url = "github:TheWanderingCrow/nvix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      ISO = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./installers/ISO.nix
          ./installer-config.nix
        ];
      };
    };
  };
}
