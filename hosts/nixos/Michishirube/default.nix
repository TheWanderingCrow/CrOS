#############################
#                           #
# Michishirube - Lighthouse #
#                           #
#############################
{
  inputs,
  lib,
  pkgs,
  ...
}: let
  srvos = inputs.srvos.nixosModules;
in {
  imports = lib.flatten [
    # Disks
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/btrfs-over-mbr-disk.nix")
    {
      _module.args = {
        disk = "/dev/sda";
        withSwap = false;
        swapSize = "0";
      };
    }
    # Misc

    srvos.server
    srvos.hardware-hetzner-cloud

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"
      # Optional configs
    ])
  ];

  time.timeZone = "UTC"; # Have to declare because of srvos

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "Michishirube";
    persistFolder = "/persist";
    isMinimal = true;
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    limine = {
      enable = true;
      biosSupport = true;
      biosDevice = "/dev/sda";
    };
  };
}
