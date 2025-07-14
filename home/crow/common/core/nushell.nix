{
  config,
  lib,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        set-nixpkgs-upstream = "git remote add upstream https://github.com/NixOS/nixpkgs.git";
        nup = "sudo nixos-rebuild switch --flake .";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
