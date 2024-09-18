{
    description = "Entry point for NixOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        firefox-addons.url = "gitlab:ryceee/nur-expressions?dir=pkgs/firefox-addons";
    };

    outputs = inputs: let
        system = "x86_64-linux";
        inherit (inputs.nixpkgs) lib;

        firefox_overlay = final: _prev: {firefox = import inputs.firefox-addons {system = final.system;};};
        overlays = [firefox_overlay];

        pkgs = import inputs.nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
        };

        ns = host: (lib.nixosSystem {
            specialArgs = {inherit pkgs inputs;};
            modules = [
                (./hosts + "/${host}")
                inputs.home-manager.nixosModules.home-manager
            ];
        });
    in {nixosConfigurations = lib.attrsets.genAttrs [ "Parzival-Mobile" ] ns;};
}
