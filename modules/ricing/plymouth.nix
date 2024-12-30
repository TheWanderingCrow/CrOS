{
  config,
  lib,
  pkgs,
  ...
}: let
  rices = {
    basic = {
      theme = "deus_ex";
      logo = null;
      font = null;
      extraConfig = "";
    };
  };

  rice = let
    enabledSet = lib.filter (set: config.ricing.${set}.enable) (lib.attrNames rices) // [null];
  in
    rices.${lib.head enabledSet} // null;
in {
  boot.plymouth = {
    enable = true;
    theme = rice.theme;
    logo = rice.logo;
    font = rice.font;
    extraConfig = rice.extraConfig;
  };
}
