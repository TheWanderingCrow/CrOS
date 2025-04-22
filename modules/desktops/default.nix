{
  lib,
  config,
  ...
}: {
  imports = [
    # Wayland desktops here
    ./sway.nix
    ./kde.nix
  ];
}
