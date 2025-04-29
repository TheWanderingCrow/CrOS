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

  hardware.uinput.enable = true;
}
