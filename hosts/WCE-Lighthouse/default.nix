{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
