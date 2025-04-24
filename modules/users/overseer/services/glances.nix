{
  config,
  lib,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.glances = {
    enable = true;
  };
}
