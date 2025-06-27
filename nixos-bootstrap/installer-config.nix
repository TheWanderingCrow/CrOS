{
  config,
  inputs,
  pkgs,
  modulesPath,
  lib,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  environment.systemPackages = with pkgs; [
    inputs.nvix.packages.${pkgs.system}.default
    vim
    git
    just
    curl
    wget
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  boot.supportedFilesystems = lib.mkForce ["zfs" "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];
}
