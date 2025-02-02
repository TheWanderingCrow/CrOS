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
      "aws_config".content = ''
        [default]
        region=${config.sops.placeholder."aws/region"}
      '';
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "infrastructure@wanderingcrow.net";
      dnsProvider = "route53";
      credentialFiles = {
        "AWS_SHARED_CREDENTIALS_FILE" = config.sops.templates."aws_shared_credentials".path;
      };
      environmentFile = config.sops.templates."aws_config".path;
    };
    certs = {
      "home.wanderingcrow.net" = {};
      "homebox.wanderingcrow.net" = {};
      "bar.wanderingcrow.net" = {};
      "bookstack.wanderingcrow.net" = {};
    };
  };
}
