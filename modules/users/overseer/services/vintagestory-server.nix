{
  pkgs,
  lib,
  config,
  ...
}: let
  modsPath = lib.mkDefault "";
  firstAdmin = lib.mkDefault "";
  serverDir = lib.mkDefault "/var/lib/vintagestory-server";
in {
  environment.systemPackages = [
    pkgs.vintagestory
  ];

  systemd.services."vintagestory-server" = {
    enable = lib.mkDefault true;
    description = "Vintage Story Server";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    path = ["${pkgs.vintagestory}"];
    serviceConfig = {
      WorkingDirectory = "${serverDir}";
      Restart = "always";
      RestartSec = "30";
      StandardOutput = "syslog";
      StandardError = "syslog";
      SyslogIdentifier = "VSSRV";
    };
  };
}
