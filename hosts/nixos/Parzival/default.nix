######################
#                    #
# Parzival - Desktop #
#                    #
######################
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    # Hardware
    ./hardware-configuration.nix # I want to use factor if possible

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
      "hosts/common/optional/pentesting.nix"
      "hosts/common/optional/gaming.nix"
      "hosts/common/optional/vbox.nix"
      "hosts/common/optional/docker.nix"
      "hosts/common/optional/printing.nix"
      "modules/services/ollama"
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "Parzival";
    persistFolder = "/persist";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    limine = {
      enable = true;
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
}
