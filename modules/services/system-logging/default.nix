{
  pkgs,
  config,
  ...
}: let
  lokiConfig = pkgs.writeText "lokiconfig" ''
    # This is a complete configuration to deploy Loki backed by the filesystem.
    # The index will be shipped to the storage via tsdb-shipper.

    auth_enabled: false

    server:
      http_listen_port: 3100

    common:
      ring:
        instance_addr: 127.0.0.1
        kvstore:
          store: inmemory
      replication_factor: 1
      path_prefix: /tmp/loki

    schema_config:
      configs:
      - from: 2020-05-15
        store: tsdb
        object_store: filesystem
        schema: v13
        index:
          prefix: index_
          period: 24h

    storage_config:
      filesystem:
        directory: /tmp/loki/chunks
  '';

  alloyConfig = pkgs.writeText "alloyconfig" '''';
in {
  services = {
    grafana = {
      enable = true;
      settings = {
        analytics.reporting_enabled = false;
        server = {
          http_addr = "127.0.0.1";
          http_port = 2432;
          enable_gzip = true;
          domain = "logs.wanderingcrow.net";
          #root_url = "https://logs.wanderingcrow.net/${config.hostSpec.hostName}";
          #serve_from_subpath = false;
        };
      };
    };
    loki = {
      enable = true;
      configFile = lokiConfig;
    };
    alloy = {
      enable = true;
      configPath = alloyConfig;
    };
  };
}
