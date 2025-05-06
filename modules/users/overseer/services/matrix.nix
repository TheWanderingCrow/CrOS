{
  lib,
  config,
  ...
}: let
  fqdn = "matrix.wanderingcrow.net";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
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
      ensureDatabases = ["matrix-synapse"];
    };

    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      vitualHosts = {
        "wanderingcrow.net" = {
          forceSSL = lib.mkDefault true;
          useACMEHosst = lib.mkDefault "wanderingcrow.net";
          locations = {
            "= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
            "= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
          };
        };
        "${fqdn}" = {
          forceSSL = true;
          useACMEHost = "${fqdn}";
          locations = {
            "/".extraConfig = ''return 404;'';
            "/_matrix".proxyPass = "http://localhost:8008";
            "/_synapse/client".proxyPass = "http://localhost:8008";
          };
        };
      };
    };

    services.matrix-synapse = {
      enable = true;
      settings = {
        server_name = "wanderingcrow.net";
        public_baseurl = baseUrl;
        listeners = [
          {
            port = 8008;
            bind_addresses = ["::1"];
            type = "http";
            tls = false;
            x_forwarded = true;
            resources = [
              {
                names = ["client" "federation"];
                compress = true;
              }
            ];
          }
        ];
        database = {
          name = "psycopg2";
          args = {
            user = "matrix-synapse";
            database = "matrix-synapse";
          };
        };
      };
    };
  }
