{
  services.xserver = {
    dpi = 180;
    displayManager = {
      importedVariables = [
        "GDK_SCALE"
        "GDK_DPI_SCALE"
        "QT_AUTO_SCREEN_SCALE"
      ];
      startx = {
        enable = true;
        generateScript = true;
      };
    };
  };

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
