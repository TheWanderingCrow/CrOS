######################
#                    #
# HandlerOne - m710q #
#                    #
######################
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    # Hardware
    ./hardware-configuration.nix

    # FIXME(TODO): Turn this into it's own backup module
    ./backup.nix

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
      "hosts/common/optional/keyd.nix"
      "hosts/common/optional/podman.nix"

      # Hosted services
      "modules/services/the-nest"
      "modules/services/actualbudget"
      "modules/services/frigate"
      "modules/services/homebox"
      "modules/services/homepage"
      "modules/services/mqtt"
      "modules/services/openhab"
      "modules/services/lubelogger"
      "modules/services/trilium"
      "modules/services/fail2ban"
      "modules/services/ntfy-sh"
      "modules/services/ollama/proxy.nix" # Just host the proxy path back to Parzival
      "modules/services/netbox"
      "modules/services/system-logging"
      "modules/services/system-logging/proxy.nix"
      "modules/services/matrix"
      "modules/services/flamesites"
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    hostName = "HandlerOne";
    persistFolder = "/persist";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall = {
      allowedTCPPorts = [80 443];
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
    };
  };

  services.caddy = {
    email = "infrastructure@wanderingcrow.net";
    acmeCA = "https://acme-v02.api.letsencrypt.org/directory";
  };
}
