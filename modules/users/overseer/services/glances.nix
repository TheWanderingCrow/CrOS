{
  config,
  lib,
  ...
}:
lib.mkIf config.user.overseer.enable {
  servicess.glances = {
    enable = true;
  };
}
