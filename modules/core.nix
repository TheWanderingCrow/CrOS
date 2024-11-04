{
   config,
   lib,
   pkgs,
   inputs,
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
            appdevel.enable = lib.mkEnableOption "enables app development in flutter";
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
            appdevel.enable = lib.mkDefault false;
        };

        desktop = {
            sway.enable = lib.mkDefault false;
            i3.enable = lib.mkDefault false;
        };
        
        xdg.portal = {
            xdgOpenUsePortal = true;
            enable = true;
            wlr.enable = true;
            lxqt.enable = true;
            extraPortals = [
                pkgs.xdg-desktop-portal-wlr
                pkgs.xdg-desktop-portal-gtk
                pkgs.xdg-desktop-portal-kde
            ];
        };
        
        # REASONING: fish is not a POSIX compliant shell so if something happens we need to use bash as the login shell to prevent an irrecoverable shell
        programs.bash = {
            interactiveShellInit = ''
                if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
                then
                    shopt -q login_shell && LOGIN_OPTION='--login || LOGIN_OPTION=""
                    exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                fi
            '';
        };
        
        programs.fish = {
            enable = true;
        };

        # Make fish default for all users
        users.defaultUserShell = pkgs.fish;
        
        # Configure pulseaudio
        hardware.graphics.enable32Bit = config.module.gaming.enable;
        hardware.pulseaudio.support32Bit = config.module.gaming.enable;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
        services.keyd = {
            enable = true;
            keyboards.default = {
                ids = [ "*" ];
                extraConfig = ''
                [global]
                
                default_layout = main

                [main:layout]
                
                capslock = layer(standardL2)
                
                [standardL2]

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
