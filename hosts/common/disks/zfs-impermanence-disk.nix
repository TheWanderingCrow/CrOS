{
  lib,
  pkgs,
  disk ? "/dev/vda",
  withSwap ? false,
  swapSize,
  config,
  ...
}: {
  disko.devices = {
    disk = {
      disk0 = {
      };
    };
  };
}
