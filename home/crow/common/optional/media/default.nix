{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      spotify
      vlc
      libreoffice-qt6-fresh
      ;
  };
}
