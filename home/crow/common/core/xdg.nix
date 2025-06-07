{
  config,
  lib,
  hostSpec,
  ...
}: {
  home = {
    preferXdgDirectories = true;
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/.desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/media/audio";
        pictures = "${config.home.homeDirectory}/media/images";
        videos = "${config.home.homeDirectory}/media/video";
      };

      extraConfig = {
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };
}
