######################
#                    #
# Dragneel - Desktop #
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
      "hosts/common/optional/printing.nix"
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    username = "drag";
    handle = "drag";
    hostName = "Dragneel";
    persistFolder = "/persist";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    interfaces.enp3s0 = {
      wakeOnLan.enable = true;
    };
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

  services.firewall.enable = false;
  services.unifi = {
    enable = true;
    openFirewall = true;
    unifiPackage = pkgs.unstable.unifi;
    mongodbPackage = pkgs.mongodb-7_0;
  };

  services.caddy = {
    enable = true;
    virtualHosts."dragneel.local".extraConfig = ''
      reverse_proxy localhost:8080
    '';
  };
}
