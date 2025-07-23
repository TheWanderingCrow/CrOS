{lib, ...}: {
  imports = [
    common/core
    common/optional/desktops/niri.nix
    common/optional/desktops/sway
    common/optional/browsers/firefox.nix
    common/optional/comms
  ];

  monitors = [
    {
      name = "eDP-1";
      primary = true;
      width = 2256;
      height = 1504;
      refreshRate = 60;
      background = lib.custom.relativeToRoot "assets/wallpapers/kali_lol.jpg";
    }
  ];
}
