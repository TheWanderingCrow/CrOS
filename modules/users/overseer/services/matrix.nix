{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  ############
  # Database #
  ############
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = ["matrix-synapse"];
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "wanderingcrow.net";
    };
  };
}
