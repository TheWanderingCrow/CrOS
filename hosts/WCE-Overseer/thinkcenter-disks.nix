{
  disko.devices = {
    disk = {
      disk0 = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zpool";
              };
            };
          };
        };
      };
    };
    zpool = {
        zroot = {
            name = "Root zpool";
            mode = "mirror";
            rootFsOptions = {
                compression = "zstd";
                "com.sun:auto-snapshot" = "false";
            };
            mountpoint = "/";
            postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";
        };
    };
  };
}
