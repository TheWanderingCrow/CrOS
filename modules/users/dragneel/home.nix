{
  osConfig,
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [];
  home = {
    username = "dragneel";
    homeDirectory = "/home/dragneel";
    stateVersion = "24.05";
  };

  xdg = {
    configHome = "/home/dragneel/.config";
    enable = true;
  };
}
