{
  inputs,
  lib,
  config,
  ...
}:
lib.mkIf config.user.lighthouse.enable {
  config.users.users.lighthouse = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
    ];
  };
}
