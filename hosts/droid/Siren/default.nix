{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  environment.packages = with pkgs; [
    inputs.nvix.packages.${pkgs.system}.default
    git
    openssh
  ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };
}
