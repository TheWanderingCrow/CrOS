let
  primary = "wanderingcrow.net";
in
  {
    lib,
    config,
    ...
  }: {
    services.nginx = {
      enable = true;
      enableReload = true;

      virtualHosts = {
        "vault.${primary}" = {
          locations = {
            "/" = {
              proxyPass = "http://localhost:8200";
            };
          };
        };
      };
    };
  }
