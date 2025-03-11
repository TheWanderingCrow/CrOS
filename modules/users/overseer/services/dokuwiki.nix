{config, ...}: {
  services.dokuwiki.sites = {
    "wiki.wanderingcrow.net" = {
      enable = true;
    };
  };
}
