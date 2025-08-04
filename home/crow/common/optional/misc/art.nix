{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      krita
      ;
  };
}
