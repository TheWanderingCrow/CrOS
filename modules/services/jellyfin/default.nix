{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./tubearchivist.nix
  ];
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
