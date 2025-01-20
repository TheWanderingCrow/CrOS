let
  volumePath = "/overseer/services";
in
  {
    lib,
    inputs,
    config,
    pkgs,
    ...
  }:
    lib.mkIf config.user.overseer.enable {
      # Some scafolding for secrets
      sops = {
        defaultSopsFile = inputs.nix-secrets.secrets.overseer;
        age.keyFile = "/var/lib/sops-nix/key.txt";
        age.sshKeyPaths = [inputs.nix-secrets.keys.overseer];
      };

      # Create the dirs we need
      systemd.tmpfiles.rules = [
        "d ${volumePath}"

        "d ${volumePath}/NPM/data 700 overseer overseer"
        "d ${volumePath}/NPM/letsencrypt 700 overseer overseer"
      ];

      # Pull in the restic secrets from sops
      sops.secrets."restic/url" = {};
      sops.secrets."restic/key" = {};
      # (Arguably) Most Important Service - backups
      services.restic.backups = {
        NPM = {
          user = "root";
          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
          };
          paths = [
            "${volumePath}/NPM/data"
            "${volumePath}/NPM/letsencrypt"
          ];
          repositoryFile = config.sops.secrets."restic/url".path;
          passwordFile = config.sops.secrets."restic/key".path;
        };
      };

      # OCI services
      virtualisation.podman.enable = true;
      virtualisation.oci-containers.backend = "podman";

      virtualisation.oci-containers.containers = {
        # NGINX Proxy Manager
        NPM = {
          image = "jc21/nginx-proxy-manager:latest";
          autoStart = true;
          ports = [
            "80:80"
            "443:443"
            "81:81"
          ];
          volumes = [
            "${volumePath}/NPM/data:/data"
            "${volumePath}/NPM/letsencrypt:/etc/letsencrypt"
          ];
        };
      };
    }
