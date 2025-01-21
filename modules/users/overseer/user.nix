{
  inputs,
  lib,
  config,
  ...
}: {
  config.users.users.overseer = lib.mkIf config.user.overseer.enable {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "libvirtd"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
      inputs.nix-secrets.keys.overseer
    ];
  };
}
