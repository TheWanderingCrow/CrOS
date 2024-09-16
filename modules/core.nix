{
   config,
   lib,
   pkgs,
   ...
}: {
   system.stateVersion = "24.05";
   time.timeZone = "America/New_York";

    options.packages = {
        enable = lib.mkEnableOption "enables packages";
        core.enable = lib.mkEnableOption "enables required packages";
        gui.enable = lib.mkEnableOption "enables gui+DE packages";
        programming.enable = lib.mkEnableOption "enables programming packages";
        hacking.enable = lib.mkEnableOption "enables hacking packages";
        mudding.enable = lib.mkEnableOption "enables mudding packages";
        gaming.enable = lib.mkEnableOption "enables gaming packages";
    };
    
    config = {
        packages = {
            enable = lib.mkDefault true;
            core.enable = lib.mkDefault true;
            gui.enable = lib.mkDefault true;
            programming.enable = lib.mkDefault true;
            hacking.enable = lib.mkDefault false;
            mudding.enable = lib.mkDefault false;
            gaming.enable = lib.mkDefault false;
        };
    };
    
}
