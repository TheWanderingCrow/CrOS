{
  inputs,
  lib,
  config,
  ...
}: {
  users.users.crow = lib.mkIf config.user.crow.enable {
    isNormalUser = true;
    hashedPassword = "$y$j9T$wDC7wMJxCLNvdf8L8s6jZ.$U06F381x07fzu.updEsoegiWtbFvsrRJ7DLN9gR7un0";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev" "dialout" "input" "uinput"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
    ];
  };

  home-manager.users.crow = lib.mkIf config.user.crow.home.enable ./home.nix;
}
