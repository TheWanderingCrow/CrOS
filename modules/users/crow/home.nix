{osConfig, config, inputs, pkgs, lib, ...}: 
let
    hyprMonitorConfig = if osConfig.networking.hostName == "Parzival" then ./configs/hypr/parzival-monitors.conf
                    else if osConfig.networking.hostName == "Parzival-Mobile" then ./configs/hypr/parzival_mobile-monitors.conf
                    else null;
    swayMonitorConfig = if osConfig.networking.hostName == "Parzival" then ./configs/sway/parzival-monitors.conf
                        else if osConfig.networking.hostName == "Parzival-Mobile" then ./configs/sway/parzival_mobile-monitors.conf
                        else null;
in                    
{
    home = {
        username = "crow";
        homeDirectory = "/home/crow";
        stateVersion = "24.05";

        # Tools
        file.".config/tmux/tmux.conf".source = ./configs/tmux/tmux.conf;
        file.".config/git/config".source = ./configs/git/git.conf;
        
        # Hyprland
        file.".config/hypr/hyprland.conf".source = ./configs/hypr/hyprland.conf;
        file.".config/hypr/monitors.conf".source = lib.mkIf (hyprMonitorConfig != null) hyprMonitorConfig;
        
        # Waybar
        file.".config/waybar/config.jsonc".source = ./configs/waybar/config.jsonc;
        file.".config/waybar/style.css".source = ./configs/waybar/style.css;
        
        # Sway
        file.".config/sway/config".source = ./configs/sway/sway.conf;
        file.".config/sway/monitors.conf".source = lib.mkIf (swayMonitorConfig != null) swayMonitorConfig;
        file.".config/sway/background-1".source = ./configs/wallpapers/cyber_defiance.jpg;
        file.".config/sway/background-2".source = ./configs/wallpapers/cyber_skyscrapers.jpg;

        # i3
        file.".config/i3/config".source = ./configs/i3/i3.conf;
        file."/home/crow/.xinitrc".source = ./configs/x11/xinitrc;
    };

    xdg = {
        configHome = "/home/crow/.config";
        enable = true;
    };
    
    programs = {
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
                ExtensionSettings = {
                    "*".installation_mode = "blocked";
                    "*".blocked_install_message = "Please manage extensions through your NixOS config";
                    # Bitwarden
                    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                        installation_mode = "force_installed";
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpl";
                        default_area = "navbar";
                    };
                    "contact@grimoire.pro" = {
                        installation_mode = "force_installed";
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/contact@grimoire.pro/latest.xpl";
                        default_area = "navbar";
                    };
                    "uBlock0@raymondhill.net" = {
                        installation_mode = "force_installed";
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpl";
                        default_area = "menupanel";
                    };
                    # Vimium
                    "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
                        installation_mode = "force_installed";
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/{d7742d87-e61d-4b78-b8a1-b469842139fa}/latest.xpl";
                        default_area = "menupanel";
                    };
                };
            };
        };
    };
}
