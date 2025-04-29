{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./topology-config.nix
    ../../modules
  ];

  networking.hostName = "Parzival";

  user.crow.enable = true;

  desktop.sway.enable = true;

  module.gui.enable = true;
  module.programming.enable = true;
  module.hacking.enable = true;
  module.mudding.enable = true;
  module.gaming.enable = true;
  module.appdevel.enable = true;
  module.hobbies.enable = true;

  programs.noisetorch.enable = true;

  virtualisation.virtualbox.host = {
    enableKvm = true;
    enable = true;
    addNetworkInterface = false;
  };

  environment.systemPackages = [
    pkgs.antimicrox
  ];
}
