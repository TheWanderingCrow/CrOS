{
   config,
   lib,
   pkgs,
   ...
}: {
    options = {
        packages = {
            enable = lib.mkEnableOption "enables packages";
            core.enable = lib.mkEnableOption "enables required packages";
            gui.enable = lib.mkEnableOption "enables gui+DE packages";
            programming.enable = lib.mkEnableOption "enables programming packages";
            hacking.enable = lib.mkEnableOption "enables hacking packages";
            mudding.enable = lib.mkEnableOption "enables mudding packages";
            gaming.enable = lib.mkEnableOption "enables gaming packages";
        };
        
        users = {
            enable = lib.mkEnableOption "enables users";
            crow = {
                enable = lib.mkEnableOption "enable crow";
                home.enable = lib.mkEnableOption "enable home configuration";
            };
        };
    };
    
    config = {
        system.stateVersion = "24.05";
        time.timeZone = "America/New_York";

        users = {
            enable = lib.mkDefault true;
            crow = {
                enable = lib.mkDefault true;
                home.enable = lib.mkDefault true;
            };
        };

        fonts.packages = with pkgs; [
            nerdfonts
        ];
        
        packages = {
            enable = lib.mkDefault true;
            core.enable = lib.mkDefault true;
            gui.enable = lib.mkDefault true;
            programming.enable = lib.mkDefault true;
            hacking.enable = lib.mkDefault false;
            mudding.enable = lib.mkDefault false;
            gaming.enable = lib.mkDefault false;
        };
        
        hypr.enable = lib.mkDefault false;

        # Configure pulseaudio
        hardware.pulseaudio.enable = lib.mkDefault true;
        services.pipewire.enable = false;
        services.keyd = {
            enable = true;
            keyboards.default = {
                ids = [ "*" ];
                settings = {
                    main = {
                        capslock = "layer(l2)";
                    };
                    l2 = {
                        w = "up";
                        a = "left";
                        s = "down";
                        d = "right";

                        b = "C-b";

                        space = "playpause";
                        ''. = "nextsong";
                        '', = "prevsong";

                        escape = "~";
                        home = "end";
                    };
                };
            };
        };
    };
}
