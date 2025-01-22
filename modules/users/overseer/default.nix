{
  lib,
  config,
  ...
}: {
  imports = [
    ./user.nix
    ./secrets.nix
    ./services.nix
  ];
}
