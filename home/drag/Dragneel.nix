{lib, ...}: {
  imports = [
    common/core
    common/optional/desktops/kde
    common/optional/browsers/firefox.nix
    common/optional/browsers/chromium.nix
    common/optional/comms
    common/optional/media
    common/optional/gaming
  ];

  monitors = [
  ];
}
