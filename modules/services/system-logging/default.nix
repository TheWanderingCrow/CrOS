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
in {
  # As per the entrry in nixos options
  environment.etc."allow/config.alloy".text = ''
        loki.write "local" {
      endpoint {
        url = "http://localhost:3100/loki/api/v1/push"
      }
    }

    loki.relabel "journal" {
      forward_to = []

      rule {
        source_labels = ["__journal__systemd_unit"]
        target_label  = "unit"
      }
      rule {
        source_labels = ["__journal__boot_id"]
        target_label  = "boot_id"
      }
      rule {
        source_labels = ["__journal__transport"]
        target_label  = "transport"
      }
      rule {
        source_labels = ["__journal_priority_keyword"]
        target_label  = "level"
      }
      rule {
        source_labels = ["__journal__hostname"]
        target_label  = "instance"
      }
    }

    loki.source.journal "read" {
      forward_to = [
        loki.write.local.receiver,
      ]
      relabel_rules = loki.relabel.journal.rules
      labels = {
        "job" = "integrations/node_exporter",
      }
    }
  '';

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
    };
  };
}
