{
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 6;
  nix.extraOptions = ''
    extra-experimental-features = nix-command
    extra-experimental-features = flakes
  '';
}
