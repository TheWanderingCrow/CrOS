{
  description = "CrOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    crowpkgs.url = "github:TheWanderingCrow/crowpkgs";
    nix-secrets = "github:TheWanderingCrow/nix-secrets";

    sops-nix.url = "github:Mic92/sops-nix";
  };
}
