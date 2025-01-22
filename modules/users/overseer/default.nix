{
  lib,
  config,
  ...
}: {
  imports = [
    ./user.nix
    ./services.nix
    ./secrets.nix
  ];
}
