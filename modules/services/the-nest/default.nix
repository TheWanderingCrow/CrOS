{
  lib,
  config,
  inputs,
  ...
}: {
  services = {
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "wanderingcrow.net" = {
          default = true;
          forceSSL = true;
          useACMEHost = "wanderingcrow.net";
          locations."/" = {
            root = inputs.the-nest.outputs.packages.x86_64-linux.default;
          };
        };
      };
    };
  };
}

