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
  };
}
