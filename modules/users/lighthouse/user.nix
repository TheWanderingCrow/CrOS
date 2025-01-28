{
  inputs,
  lib,
  config,
  ...
}: {
  config.users.users.lighthouse = lib.mkIf config.user.lighthouse.enable {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
    ];
  };
}
