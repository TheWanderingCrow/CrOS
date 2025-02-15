{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services.nginx.virtualHosts."grocy.wanderingcrow.net" = {
    forceSSL = true;
    useACMEHost = "grocy.wanderingcrow.net";
    extraConfig = ''
      allow 192.168.0.0/16;
      allow 10.8.0.0/24;
      deny all;
    '';
  };

  services.grocy = {
    enable = true;
    hostName = "grocy.wanderingcrow.net";
    nginx.enableSSL = false;
  };
}
