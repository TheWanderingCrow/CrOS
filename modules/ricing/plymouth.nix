{
  config,
  lib,
  pkgs,
  ...
}: let
  rices = {
    basic = {
      enable = true;
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["deus_ex"];
        })
      ];
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
