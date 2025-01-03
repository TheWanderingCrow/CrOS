{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules
  ];

  networking.hostName = "WCE-Overseer";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  user.overseer.enable = true;
}
