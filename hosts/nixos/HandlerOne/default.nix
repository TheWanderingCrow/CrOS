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

      # Hosted services
      "modules/services/actualbudget"
      "modules/services/bar-assistant"
      "modules/services/frigate"
      "modules/services/grocy"
      "modules/services/homebox"
      "modules/services/homepage"
      "modules/services/lubelogger"
      "modules/services/trilium"
      "modules/services/umami"
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

  #FIXME(TODO) Migrate this into another file, probably a module
  sops = {
    secrets = {
      "aws/access_key" = {};
      "aws/secret_key" = {};
      "aws/region" = {};
    };
    templates = {
      "aws_shared_credentials".content = ''
        [default]
        aws_access_key_id=${config.sops.placeholder."aws/access_key"}
        aws_secret_access_key=${config.sops.placeholder."aws/secret_key"}
      '';
      "aws_env".content = ''
        AWS_REGION=${config.sops.placeholder."aws/region"}
      '';
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "infrastructure@wanderingcrow.net";
      group = config.services.nginx.group;
      dnsProvider = "route53";
      credentialFiles = {
        "AWS_SHARED_CREDENTIALS_FILE" = config.sops.templates."aws_shared_credentials".path;
      };
      environmentFile = config.sops.templates."aws_env".path;
    };
    certs = {
      "wanderingcrow.net" = {};
      "umami.wanderingcrow.net" = {};
      "garage.wanderingcrow.net" = {};
      "bar.wanderingcrow.net" = {};
      "home.wanderingcrow.net" = {};
      "homebox.wanderingcrow.net" = {};
      "cache.wanderingcrow.net" = {};
      "openhab.wanderingcrow.net" = {};
      "frigate.wanderingcrow.net" = {};
      "notes.wanderingcrow.net" = {};
      "grocy.wanderingcrow.net" = {};
      "barcodebuddy.grocy.wanderingcrow.net" = {};
      "budget.wanderingcrow.net" = {};
      "matrix.wanderingcrow.net" = {};
    };
  };
}
