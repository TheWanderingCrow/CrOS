let
  volumePath = "/overseer/services";
in
  {
    lib,
    config,
    pkgs,
    ...
  }: {
    # Create the dirs we need
    systemd.tmpfiles.rules = [
      "d ${volumePath}"
      "d ${volumePath}/vault/data 700 overseer overseer" # Vault says this needs to already exist upon boot

      "d ${volumePath}/paperless/data 700 overseer overseer"
      "d ${volumePath}/paperless/media 700 overseer overseer"
    ];

    # (Arguably) Most Important Service - backups
    services.restic.backups = {
      vault = {
        user = "root";
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
        };
      };
    };

    # Vault Service
    #services.vault = {
    #    enable = true;
    #    package = pkgs.vault-bin;
    #    storageBackend = "raft";
    #    storagePath = "${volumePath}/vault/data";
    #    address = "127.0.0.1:8200";
    #    extraConfig = ''
    #        ui = true
    #        api_addr = "http://127.0.0.1:8200"
    #        cluster_addr = "http://127.0.0.1:8201"
    #    '';
    #};

    # Paperless-ngx
    #services.paperless = {
    #    enable = true;
    #    mediaDir = "${volumePath}/paperless/media";
    #    dataDir = "${volumePath}/paperless/data";
    #};

    # OCI services
    virtualisation.podman.enable = true;
    virtualisation.oci-containers.backend = "podman";

    virtualisation.oci-containers.containers = {
      ## NGINX Proxy Manager
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
