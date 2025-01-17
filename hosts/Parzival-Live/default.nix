{
  config,
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    ../../modules
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nix.settings.auto-optimise-store = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  boot.supportedFilesystems = lib.mkForce ["zfs" "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
  networking.wireless.enable = false;

  user.live.enable = true;

  module.programming.enable = true;
}
