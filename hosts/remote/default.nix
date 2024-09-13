{ pkgs,
  ...
}:{
    imports = [
    ./hardware-configuration.nix
    ../../modules
    ];
    networking.hostName = "nixos-remote";
    environment.systemPackages = [
        pkgs.git
        pkgs.vim
        pkgs.wget
    ];

    boot.loader.grub.device = "/dev/xvda";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.efiInstallAsRemovable = true;
    boot.loader.timeout = 1;
    boot.loader.grub.extraConfig = ''
      serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1
      terminal_output console serial
      terminal_input console serial
    '';
}
