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
}: {
  imports = lib.flatten [
    # Disks
    (map lib.custom.relativeToRoot [
      "hosts/common/disks/digital-ocean-disks.nix"
    ])
    # Misc

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"

      # Optional configs
    ])
  ];

  services.octoprint = {
    enable = true;
    openFirewall = true;
    port = 5000;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "Michishirube";
    isMinimal = true;
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
