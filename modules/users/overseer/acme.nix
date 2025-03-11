{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    secrets = {
      "aws/access_key" = {};
      "aws/secret_key" = {};
      "aws/region" = {};
    };
    templates = {
      "aws_shared_credentials".content = ''
        [default]
        aws_access_key_id=${config.sops.placeholder."aws/access_key"}
        aws_secret_access_key=${config.sops.placeholder."aws/secret_key"}
      '';
      "aws_env".content = ''
        AWS_REGION=${config.sops.placeholder."aws/region"}
      '';
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "infrastructure@wanderingcrow.net";
      group = config.services.nginx.group;
      dnsProvider = "route53";
      credentialFiles = {
        "AWS_SHARED_CREDENTIALS_FILE" = config.sops.templates."aws_shared_credentials".path;
      };
      environmentFile = config.sops.templates."aws_env".path;
    };
    certs = {
      "wanderingcrow.net" = {};
      "umami.wanderingcrow.net" = {};
      "garage.wanderingcrow.net" = {};
      "bar.wanderingcrow.net" = {};
      "home.wanderingcrow.net" = {};
      "homebox.wanderingcrow.net" = {};
      "cache.wanderingcrow.net" = {};
      "openhab.wanderingcrow.net" = {};
      "frigate.wanderingcrow.net" = {};
      "wiki.wanderingcrow.net" = {};
    };
  };
}
