{
  lib,
  config,
  ...
}: {
  imports = [
    ./user.nix
    ./setup.nix
    ./secrets.nix
    ./services
  ];
}
