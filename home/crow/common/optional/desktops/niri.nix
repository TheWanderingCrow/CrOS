{
  pkgs,
  inputs,
  config,
  ...
}: {
  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
  ];
  home.packages = [
    pkgs.niri
  ];

  programs.niri = {
    enable = true;
    settings = {
    };
  };
}
