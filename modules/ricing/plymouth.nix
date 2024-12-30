{
  config,
  lib,
  pkgs,
  ...
}: let
  rices = {
    basic = {
      enable = true;
      theme = "deus_ex";
      extraConfig = "";
    };
  };

  rice = let
    enabledSet = lib.filter (set: config.ricing.${set}.enable) (lib.attrNames rices);
  in
    rices.${lib.head enabledSet};
in {
  boot.plymouth = rice;
}
