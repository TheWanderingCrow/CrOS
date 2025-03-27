{
  config,
  lib,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.calibre-web = {
    enable = true;
  };
}
