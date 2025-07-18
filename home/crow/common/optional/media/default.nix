{pkgs, ...}: {
  home.packages = with pkgs; [
    spotify
    vlc
    libreoffice-qt6-fresh
  ];
}
