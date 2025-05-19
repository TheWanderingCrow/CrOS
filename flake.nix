{
  description = "CrOS Ecosystem";

  inputs = {
    # Official inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # 3rd party inputs
    sops-nix.url = "github:Mic92/sops-nix";

    # CrOS inputs
    nix-secrets.url = "github:TheWanderingCrow/nix-secrets";
  };
}
