#################################
#                               #
# Incarceron - Laptop           #
# NixOS running on Framework 13 #
#                               #
#################################
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    # Hardware
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix

    # Disks
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/btrfs-disk.nix")
    {
      _module.args = {
        disk = "/dev/nvme0n1";
        withSwap = true;
        swapSize = "8";
      };
    }

    # Misc

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"

      # Optional configs
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/bluetooth.nix"
      "hosts/common/optional/keyd.nix"
      "hosts/common/optional/pentesting.nix"
      "hosts/common/optional/printing.nix"
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "Incarceron";
    persistFolder = "/persist";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
    };
  };
}
