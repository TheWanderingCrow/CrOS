{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ferdium
      discord
      mattermost
      slack
      zoom
      ;
  };
}
