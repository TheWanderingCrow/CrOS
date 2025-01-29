{
  lib,
  config,
  ...
}: {
  imports = [
    ./network.nix
    ./audio.nix
    ./graphics.nix
  ];
}
