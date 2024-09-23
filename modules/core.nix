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
            wayland.enable = lib.mkEnableOption "enables wayland packages";
            x11.enable = lib.mkEnableOption "enables x11 packages";
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
            vault = {
                enable = lib.mkEnableOption "enable vault";
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

        users = {
            enable = lib.mkDefault true;
            crow = {
                enable = lib.mkDefault true;
                home.enable = lib.mkDefault true;
            };
            vault = {
                enable = lib.mkDefault false;
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
            wayland.enable = lib.mkDefault config.hyprland.enable;
            x11.enable = lib.mkDefault false;
            hacking.enable = lib.mkDefault false;
            mudding.enable = lib.mkDefault false;
            gaming.enable = lib.mkDefault false;
        };
        
        hyprland.enable = lib.mkDefault false;

        # Configure pulseaudio
        hardware.graphics.enable32Bit = config.packages.gaming.enable;
        hardware.pulseaudio.support32Bit = config.packages.gaming.enable;
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
