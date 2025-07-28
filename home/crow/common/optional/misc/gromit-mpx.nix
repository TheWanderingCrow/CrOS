# Allows drawing over the screen overlay with our fancy wacom tablet
{pkgs, ...}: let
  makimaConfig = ''
    [commands]
    BTN_STYLUS = ["gromit-mpx -t"]

    [settings]
    GRAB_DEVICE = "false"
  '';
in {
  home.file.".config/makima/Wacom One by Wacom S Pen.toml".text = makimaConfig;

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      makima
      gromit-mpx
      ;
  };
}
