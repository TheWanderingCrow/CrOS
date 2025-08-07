# NOTE: ... is needed because dikso passes diskoFile
{
  lib,
  disk ? "/dev/vda",
  withSwap ? false,
  swapSize,
  ...
}: {
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = disk;
        content = {
          type = "gpt";
          partitions = {
            boot = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF02";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
