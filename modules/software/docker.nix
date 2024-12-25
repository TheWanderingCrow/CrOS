{
  config,
  lib,
  ...
}: {
  virtualisation.docker = lib.mkIf config.software.docker.enable {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
