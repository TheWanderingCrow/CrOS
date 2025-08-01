{
  fileSystems."/" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  fileSystems."/efi" = {
    device = "systemd-1";
    fsType = "autofs";
  };
}
