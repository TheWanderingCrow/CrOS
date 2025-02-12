{
  lib,
  config,
  inputs,
  ...
}:
lib.mkIf config.user.overseer.enable {
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "wanderingcrow.net";
          root = inputs.the-nest;
        };
      };
    };
  };
}
