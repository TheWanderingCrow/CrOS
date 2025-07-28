{
  inputs,
  pkgs,
  lib,
  ...
}: let
  loginKey = builtins.readFile ./installer.pub;
in {
  environment.systemPackages = builtins.attrValues {
    inherit (inputs.nvix.packages.${pkgs.system}) default;
    inherit
      (pkgs)
      vim
      git
      just
      curl
      wget
      disko
      ;
  };

  boot.supportedFilesystems = lib.mkForce ["zfs" "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs"];

  networking = {
    wireless.enable = lib.mkForce false;
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  users.users.nixos.openssh.authorizedKeys.keys = [loginKey];
  users.users.root.openssh.authorizedKeys.keys = [loginKey];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };
}
