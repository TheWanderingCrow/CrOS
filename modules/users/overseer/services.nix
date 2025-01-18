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
        age.generateKey = true;
      };

      # Create the dirs we need
      systemd.tmpfiles.rules = [
        "d ${volumePath}"

        "d ${volumePath}/paperless/data 700 overseer overseer"
        "d ${volumePath}/paperless/media 700 overseer overseer"

        "d ${volumePath}/NPM/data 700 overseer overseer"
        "d ${volumePath}/NPM/letsencrypt 700 overseer overseer"
      ];

      # (Arguably) Most Important Service - backups
      services.restic.backups = {
      };

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
        #NPM = {
        #  image = "jc21/nginx-proxy-manager:latest";
        #  autoStart = true;
        #  ports = [
        #    "80:80"
        #    "443:443"
        #    "81:81"
        #  ];
        #  volumes = [
        #    "${volumePath}/NPM/data:/data"
        #    "${volumePath}/NPM/letsencrypt:/etc/letsencrypt"
        #  ];
        #};
      };
    }
