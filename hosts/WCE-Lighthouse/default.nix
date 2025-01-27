{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules
  ];

  networking.hostName = "WCE-Lighthouse";
  nixpkgs.hostPlatform = "x86_64-linux";
}
