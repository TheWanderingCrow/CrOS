{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.nginx.virtualHosts."grocy.wanderingcrow.net" = {
    forceSSL = true;
    useACMEHost = "grocy.wanderingcrow.net";
  };

  services.grocy = {
    enable = true;
    hostName = "grocy.wanderingcrow.net";
    nginx.enableSSL = false;
  };
}
