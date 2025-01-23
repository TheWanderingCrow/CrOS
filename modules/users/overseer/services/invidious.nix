{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.overseer.enable {
    
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "vid.wanderingcrow.net" = {
        enableACME = false;
        forceSSL = false;
      };
    };
  };
  
    services.invidious = {
        enable = true;
        port = 3000;
        nginx.enable = true;
        domain = "vid.wanderingcrow.net";
        database.createLocally = true;
    };
}
