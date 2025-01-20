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

  users.users.nixos.authorizedKeys.keys = lib.mkForce [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCccZhYmAIdbBv0vuvhKvnD0sm6dphdngef1jFwDhcUexoEZq8sXB3N69gsQV+ievv++T5SfEwLPEJSgVEwtwYHTCwxnGscD+thYXOacoMr3++1toCKgFHLIWrbma8jSzSDp8ERuVcbeYo/xckxCL3+axlUmyQw6TXsDbOJTYhGuJdCMlHJNl0EftwgnJZ4e+WqW/5jmG9Nu3KDgpyjYVA4v6xtkjS+NCVA3jOdDs0JPFemhb2b5ItAGe60IH65PaX63QFysxMWil0+EF04L+23sYwRMMfz9F/AX62uonemzROTAIu78grUWgjHqGQ2yOhdnOwNT0wox1KhG+r/lvFX"
  ];

  user.live.enable = true;

  module.programming.enable = true;
}
