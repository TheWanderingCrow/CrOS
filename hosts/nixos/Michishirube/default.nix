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
    (lib.custom.relativeToRoot "hosts/common/disks/hetzner-disks.nix")

    # Misc

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"

      # Optional configs
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "Michishirube";
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
