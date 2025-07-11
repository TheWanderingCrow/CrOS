{lib, ...}: {
  imports = [
    common/core
    common/optional/desktops/sway
    common/optional/browsers/firefox.nix
    common/optional/comms
    common/optional/media
  ];

  monitors = [
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 75;
      transform = 270;
      background = lib.custom.relativeToRoot "assets/wallpapers/desert_worm.jpg";
    }
    {
      name = "DP-1";
      primary = true;
      width = 2560;
      height = 1440;
      refreshRate = 170;
      x = 1080;
      y = 215;
      background = lib.custom.relativeToRoot "assets/wallpapers/barren_desert.jpg";
    }
  ];
}
