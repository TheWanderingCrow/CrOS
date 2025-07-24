{lib, ...}: {
  imports = [
    common/core
    common/optional/desktops/sway
    common/optional/desktops/niri.nix
    common/optional/browsers/firefox.nix
    common/optional/comms
    common/optional/media
    common/optional/gaming
  ];

  monitors = [
    {
      name = "eDP-1";
      primary = true;
      width = 2650;
      height = 1440;
      refreshRate = 60;
      background = lib.custom.relativeToRoot "assets/wallpapers/kali_lol.jpg";
    }
  ];
}
