{
  inputs,
  lib,
  config,
  ...
}:
lib.mkIf config.user.live.enable {
  config.users.users.live = {
    isNormalUser = true;
    initialPassword = "live";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
    ];
  };
}
