{
  pkgs,
  inputs,
  ...
}: let
  volumePath = "/overseer/services";
in {
  systemd.tmpfiles.rules = [
    "d ${volumePath}/flamesites 0750 crow"
    "d ${volumePath}/flamesites/swgalaxyproject 0750 crow"
    "d ${volumePath}/flamesites/nnsbluegrass 0750 crow"
  ];

  systemd.timers.flamesite-backup = {
    enable = true;
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1hr";
      OnUnitActiveSec = "1hr";
      Unit = "flamesite-backup.service";
    };
  };

  systemd.services.flamesite-backup = {
    script = ''
      ${pkgs.podman}/bin/podman exec swgal_db_1 sh -c 'exec mysqldump --no-tablespaces -usgr_user -psgr_pass sgr_db' > ${volumePath}/flamesites/swgalaxyproject/db.sql
      ${pkgs.podman}/bin/podman exec nssbluegrass_db_1 sh -c 'exec mysqldump --no-tablespaces -unns_user -pnns_pass nns_db' > ${volumePath}/flamesites/nnsbluegrass/db.sql
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "crow";
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "swgalaxyproject.com".extraConfig = ''
        reverse_proxy http://localhost.8080
      '';
      "nnsbluegrass.com".extraConfig = ''
        reverse_proxy http://localhost:9821
      '';
    };
  };
}
