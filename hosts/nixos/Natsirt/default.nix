#####################
#                   #
# Natsirt - Desktop #
#                   #
#####################
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    # Hardware
    ./hardware-configuration.nix # I want to use factor if possible

    #FIXME: This will require a reinstall so probably hold off on this for now
    # Disks
    #inputs.disko.nixosModules.disko
    #(lib.custom.relativeToRoot "hosts/common/disks/btrfs-disk.nix")
    #{
    #  _module.args = {
    #    #FIXME: pretty sure this is an ssd
    #    disk = "/dev/nvme0n1";
    #    withSwap = true;
    #    swapSize = 8;
    #  };
    #}

    # Misc

    (map lib.custom.relativeToRoot [
      # Required configs
      "hosts/common/core"

      # Optional configs
      "hosts/common/optional/audio.nix"
      "hosts/common/optional/bluetooth.nix"
      "hosts/common/optional/gaming.nix"
    ])
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hostSpec = {
    username = lib.mkForce "natsirt";
    handle = lib.mkForce "natsirt";
    hostName = "Natsirt";
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

  # FIXME(todo): convert this into a desktop module
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.cups.enable = true;

  environment.systemPackages = with pkgs; [
    wine
    krita
    appimage-run
    nix-ld
    (retroarch.override {
      cores = with libretro; [
        nestopia
        dolphin
        citra
        bsnes
        parallel-n64
        pcsx2
        pcsx-rearmed
      ];
    })
    supermariowar
  ];
}
