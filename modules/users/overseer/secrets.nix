{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    defaultSopsFile = inputs.nix-secrets.secrets.overseer;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  # Restic secrets
  sops.secrets."restic/url" = {};
  sops.secrets."restic/key" = {};

  # Homepage.dev secrets
  sops.secrets."homepage/openmeteo/lat" = {};
  sops.secrets."homepage/openmeteo/long" = {};
  sops.templates."homepage-environment".content = ''
    HOMEPAGE_VAR_LAT = ${config.sops.placeholder."homepage/openmeteo/lat"}
    HOMEPAGE_VAR_LONG = ${config.sops.placeholder."homepage/openmeteo/long"}
  '';

  # Meilisearch secrets
  sops.secrets."meilisearch/masterkey" = {};
  sops.templates."meilisearch-environment".content = ''
    MEILI_MASTER_KEY = ${config.sops.placeholder."meilisearch/masterkey"}
  '';

  # Bar Assistant secrets
  sops.templates."barassistant-environment".content = ''
    MEILISEARCH_KEY = ${config.sops.placeholder."meilisearch/masterkey"}
  '';
}
