{lib, ...}: {
  # This file exists to define the options.
  # The configuration is done via the imported files.
  imports = [
    ./herbstluftwm.nix
    ./rofi.nix
  ];
}
