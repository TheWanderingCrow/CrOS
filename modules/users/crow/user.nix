{
  inputs,
  lib,
  config,
  ...
}: {
  config.users.users.crow = lib.mkIf config.user.crow.enable {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev" "dialout"];
    openssh.authorizedKeys.keyFiles = [
        inputs.nix-secrets.keys.default
    ];
  };

  config.home-manager.users.crow = lib.mkIf config.user.crow.home.enable ./home.nix;
}
