{osConfig, config, inputs, pkgs, lib, ...}: 
let
    hyprMonitorConfig = if osConfig.networking.hostName == "Parzival" then ./hypr/parzival-monitors.conf
                    else if osConfig.networking.hostName == "Parzival-Mobile" then ./hypr/parzival_mobile-monitors.conf
                    else null;
    swayMonitorConfig = if osConfig.networking.hostName == "Parzival" then ./sway/parzival-monitors.conf
                        else if osConfig.networking.hostName == "Parzival-Mobile" then ./sway/parzival_mobile-monitors.conf
                        else null;
in                    
{
    home = {
        username = "crow";
        homeDirectory = "/home/crow";
        stateVersion = "24.05";
#       file.".config/hypr/hyprland.conf".source = ./hypr/hyprland.conf;
#       file.".config/hypr/monitors.conf".source = lib.mkIf (hyprMonitorConfig != null) hyprMonitorConfig;
        file.".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
        file.".config/waybar/style.css".source = ./waybar/style.css;
        file.".config/sway/config".source = ./sway/sway.conf;
        file.".config/sway/monitors.conf".source = lib.mkIf (swayMonitorConfig != null) swayMonitorConfig;
        file.".config/sway/background-1".source = ./sway/cyber_defiance.jpg;
        file.".config/sway/background-2".source = ./sway/cyber_skyscrapers.jpg;
    };

    xdg = {
        configHome = "/home/crow/.config";
        enable = true;
    };
    
    programs = {
        waybar = {
            enable = true;
        };
        git = {
            enable = true;
            userEmail = "contact@wanderingcrow.net";
            userName = "TheWanderingCrow";
        };
        wofi = {
            enable = true;
        };
        foot = {
            enable = true;
        };
        tmux = {
            enable = true;
            extraConfig = ''
            # split panes using | and -
            bind | split-window -h
            bind - split-window -v
            unbind '"'
            unbind %

            # Alt-arrow pane nav
            bind -n M-Left select-pane -L
            bind -n M-Right select-pane -R
            bind -n M-Up select-pane -U
            bind -n M-Down select-pane -D
            '';
        };
        firefox = {
            enable = true;
            policies = {
                BlockAboutConfig = true;
                DisableFirefoxStudies = true;
                DisableFormHistory = true;
                DisablePasswordReveal = true;
                DisablePocket = true;
                DisableProfileImport = true;
                DontCheckDefaultBrowser = true;
                EnableTrackingProtection = {
                    Value = true;
                    Locked = true;
                    Cryptomining = true;
                    Fingerprinting = true;
                };
                Homepage = {
                    URL = "https://home.wanderingcrow.net";
                    StartPage = "homepage";
                };
                OfferToSaveLogins = false;
                PasswordManagerEnabled = false;
            };
            profiles.crow = {
                extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                    ublock-origin
                    bitwarden
                    vimium
                ];
                settings = {
                    "extensions.autoDisableScopes" = 0; # auto enable our extensions
                };
            };
	};
    };
}
