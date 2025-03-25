{
  inputs,
  lib,
  config,
  ...
}:
lib.mkIf config.user.dragneel.enable {
  users.users.dragneel = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$QA39xfvBrwChIi7CBsLgn.$jyWUKiP6QGY4rMtFTcBZgw7s1IJdiaIK6ZUwnU3Wmj7";
    group = "wheel";
    extraGroups = ["wheel" "networkmanager" "audio" "plugdev"];
    openssh.authorizedKeys.keyFiles = [
      inputs.nix-secrets.keys.default
    ];
  };

  home-manager.users.dragneel = ./home.nix;
}
