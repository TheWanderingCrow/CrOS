{
  pkgs,
  lib,
  config,
  ...
}: {
  config.users.users.crow = lib.mkIf config.user.crow.enable {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev"];
  };

  config.home-manager.users.crow = lib.mkIf config.user.crow.home.enable ./home.nix;
}
