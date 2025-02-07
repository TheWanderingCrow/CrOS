{
  lib,
  inputs,
  config,
  ...
}:
lib.mkIf config.user.crow.enable {
  sops = {
    defaultSopsFile = inputs.nix-secrets.secrets.parzival;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  #######
  # AWS #
  #######

  sops.secrets."aws/wce/access_key" = {};
  sops.secrets."aws/wce/secret_key" = {};
  sops.secrets."aws/work/access_key" = {};
  sops.secrets."aws/work/secret_key" = {};

  sops.templates."aws_shared_config" = {
    owner = config.users.users.crow.name;
    content = ''
      [default]
      aws_access_key_id=${config.sops.placeholder."aws/work/access_key"}
      aws_secret_access_key=${config.sops.placeholder."aws/work/secret_key"}

      [wce]
      aws_access_key_id=${config.sops.placeholder."aws/wce/access_key"}
      aws_secret_access_key=${config.sops.placeholder."aws/wce/secret_key"}
    '';
  };
}
