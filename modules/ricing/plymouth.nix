{
  config,
  lib,
  pkgs,
  ...
}: let
  basic = {
    theme = "breeze";
    logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";
    font = "${pkgs.dejavu_fonts.minimal}/share/fonts/truetype/DejaVuSans.ttf";
    extraConfig = "";
  };
in {
  boot.plymouth = {
    theme =
      if config.ricing.basic.enable
      then basic.theme
      else null;
    logo =
      if config.ricing.basic.enable
      then basic.logo
      else null;
    font =
      if config.ricing.basic.enable
      then basic.font
      else null;
    extraConfig =
      if config.ricing.basic.enable
      then basic.extraConfig
      else null;
  };
}
