{
  lib,
  config,
  ...
}: let
  volumePath = "/overseer/services";
in {
  systemd.tmpfiles.rules = [
    "d ${volumePath}/ferdium-server/data"
    "d ${volumePath}/ferdium-server/app/recipes"
  ];

  services.caddy = {
    enable = true;
    virtualHosts."ferdium.wanderingcrow.net".extraConfig = ''
      reverse_proxy http://10.88.0.13:3333
    '';
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      "ferdium-api" = {
        image = "ferdium/ferdium-server:latest";
        volumes = [
          "${volumePath}/ferdium-server/data:/data"
          "${volumePath}/ferdium-server/app/recipes:/app/recipes"
        ];
        extraOptions = ["--ip=10.88.0.13"];
        environment = {
          NODE_ENV = "production";
          APP_URL = "ferdium.wanderingcrow.net";
          DB_CONNECTION = "sqlite";
          DB_HOST = "127.0.0.1";
          DB_PORT = "3306";
          DB_USER = "root";
          DB_PASSWORD = "password"; # Do I need to change this for sqlite I dont think so
          DB_DATABASE = "ferdium";
          DB_SSL = "false";
          MAIL_CONNECTION = "smtp";
          SMTP_HOST = "127.0.0.1";
          SMTP_PORT = "2525";
          MAIL_SSL = "false";
          MAIL_USERNAME = "username";
          MAIL_PASSWORD = "password";
          MAIL_SENDER = "noreply@mail.wanderingcrow.net";
          IS_CREATION_ENABLED = "true";
          IS_DASHBOARD_ENABLED = "true";
          IS_REGISTRATION_ENABLED = "true";
          CONNECT_WITH_FRANZ = "false";
          DATA_DIR = "/data";
          JWT_USE_PEM = "true";
        };
      };
    };
  };
}
