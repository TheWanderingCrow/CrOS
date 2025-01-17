{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "WCE-Overseer";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  user.overseer.enable = true;
}
