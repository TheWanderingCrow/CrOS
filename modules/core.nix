{
   config,
   lib,
   pkgs,
   ...
}: {
    options = {
        module = {
            enable = lib.mkEnableOption "enables packages";
            core.enable = lib.mkEnableOption "enables required packages";
            gui.enable = lib.mkEnableOption "enables gui+DE packages";
            wayland.enable = lib.mkEnableOption "enables wayland packages";
            x11.enable = lib.mkEnableOption "enables x11 packages";
            programming.enable = lib.mkEnableOption "enables programming packages";
            hacking.enable = lib.mkEnableOption "enables hacking packages";
            mudding.enable = lib.mkEnableOption "enables mudding packages";
            gaming.enable = lib.mkEnableOption "enables gaming packages";
        };
        
        user = {
            enable = lib.mkEnableOption "enables users";
            crow = {
                enable = lib.mkEnableOption "enable crow";
                home.enable = lib.mkEnableOption "enable home configuration";
            };
            overseer = {
                enable = lib.mkEnableOption "enable container overseer user";
            };
        };
    };
    
    config = {
        system.stateVersion = "24.05";
        time.timeZone = "America/New_York";
        nix.settings.experimental-features = ["flakes" "nix-command"];
        
        environment.variables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
        };

        user = {
            enable = lib.mkDefault true;
            crow = {
                enable = lib.mkDefault false;
                home.enable = lib.mkDefault config.user.crow.enable;
            };
            overseer = {
                enable = lib.mkDefault false;
            };
        };

        fonts.packages = with pkgs; [
            font-awesome
            nerdfonts
        ];

        
        module = {
            enable = lib.mkDefault true;
            core.enable = lib.mkDefault true;
            gui.enable = lib.mkDefault false;
            programming.enable = lib.mkDefault false;
            wayland.enable = lib.mkDefault false;
            x11.enable = lib.mkDefault false;
            hacking.enable = lib.mkDefault false;
            mudding.enable = lib.mkDefault false;
            gaming.enable = lib.mkDefault false;
        };

        desktop = {
            sway = lib.mkDefault false;
        };
        
        # Configure pulseaudio
        hardware.graphics.enable32Bit = config.module.gaming.enable;
        hardware.pulseaudio.support32Bit = config.module.gaming.enable;
        hardware.pulseaudio.enable = lib.mkDefault true;
        services.pipewire.enable = false;
        services.keyd = {
            enable = true;
            keyboards.default = {
                ids = [ "*" ];
                extraConfig = ''
                [main]

                capslock = layer(l2)

                [l2]

                w = up
                s = down
                a = left
                d = right

                b = C-b

                space = playpause
                . = nextsong
                , = previoussong

                [ = delete
                ] = end
                escape = ~

                home = end
                '';
            };
        };
    };
}
