{
  config,
  lib,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    secrets = {
      "gitlab/db_password" = {};
      "gitlab/secrets/db" = {};
      "gitlab/secrets/jws" = {};
      "gitlab/secrets/otp" = {};
      "gitlab/secrets/secret" = {};
    };
  };

  services.gitlab = {
    enable = true;
    host = "git.wanderingcrow.net";
    https = true;
    databaseCreateLocally = true;
    databasePasswordFile = config.sops.secrets."gitlab/db_password";
    initialRootPasswordFile = config.sops.secrets."gitlab/initial_root";
    secrets = {
      secretFile = config.sops.secrets."gitlab/secrets/secret";
      otpFile = config.sops.secrets."gitlab/secrets/otp";
      jwsFile = config.sops.secrets."gitlab/secrets/jws";
      dbFile = config.sops.secrets."gitlab/secrets/db";
    };
  };
}
