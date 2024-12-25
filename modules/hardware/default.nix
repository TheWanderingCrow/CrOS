{
  lib,
  config,
  ...
}: {
  imports = [
    ./network.nix
    ./audio.nix
    ./boot.nix
    ./graphics.nix
  ];
}
