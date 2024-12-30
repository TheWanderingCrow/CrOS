{
  lib,
  config,
  ...
}: {
  config = {
    programs.niri = lib.mkIf config.desktop.niri.enable {
      enable = true;
    };

    environment = lib.mkIf config.desktop.niri.enable {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
