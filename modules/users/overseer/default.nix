{
  lib,
  config,
  ...
}: {
  imports = [
    ./user.nix
    ./routing.nix
    ./services.nix
  ];
}
