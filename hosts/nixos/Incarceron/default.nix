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
    ./hardware-configuration.nix # I want to use factor if possible

    # Disks
    inputs.disko.nixosModules.disko

    # Misc

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"

      # Optional configs
      "hosts/common/optional/keyd.nix"
    ])
  ];
}
