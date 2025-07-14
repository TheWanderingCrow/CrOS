{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestions = {
      enable = true;
      async = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      lah = "ls -lah";
      set-nixpkgs-upstream = "git remote add upstream https://github.com/NixOS/nixpkgs.git";
      nup = "sudo nixos-rebuild switch --flake .";
    };
  };
}
