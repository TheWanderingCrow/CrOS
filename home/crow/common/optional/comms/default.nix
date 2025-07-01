{pkgs, ...}: {
  home.packages = with pkgs; [
    ferdium
    discord
    mattermost
    slack
    zoom
  ];
}
