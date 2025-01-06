{
  lib,
  config,
  ...
}: {
  config.users.users.overseer = lib.mkIf config.user.overseer.enable {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "libvirtd"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKCBmjkaAWNBQ6NwiK56miuv30pjheNTZfrULRfPRmed"
    ];
  };
}
