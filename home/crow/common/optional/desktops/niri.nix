{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.niri
  ];
}
