{ inputs, pkgs, lib, config, ...}: {
    environment.systemPackages = with pkgs;
        (
            # Core packages
            if config.packages.core.enable
            then [
                vim
                wget
                screen
                git
                curl
                tmux
                pulseaudio
                keyd
            ] else []
        )
        ++ (
            if config.packages.gui.enable
            then [
                # Writing
                logseq
                hunspellDicts.en-us
                libreoffice
                hunspell

                # Audio
                pavucontrol
                pulsemixer
                noisetorch

                # Communication
                mattermost-desktop
                slack
                zoom-us
                vesktop
                signal-desktop
                teamspeak_client

                # Browsing
                tor-browser

                # Music
                spotify
                strawberry-qt6

                # Utilities
                taskwarrior3
                hyfetch
                gimp
                pulseaudio-ctl
                playerctl
                brightnessctl
            ] else []
        )
        ++ (
            if config.packages.wayland.enable
            then [
               foot
               wofi
               swaynotificationcenter
               udiskie
               polkit_gnome
               swayidle
               sway-audio-idle-inhibit
               swaylock-effects
               sway-contrib.grimshot
               glfw-wayland-minecraft
            ] else []
        )
        ++ (
            if config.packages.x11.enable
            then [] else []
        )
        ++ (
            if config.packages.programming.enable
            then [
	    	inputs.nixvim.packages.${pkgs.system}.default
                lua
                libgcc
                php83
                php83Packages.composer
                python3
                serverless
                jwt-cli
                jq
                ddev
                cloc
                ansible
                flutter
            ] else []
        )
        ++ (
            if config.packages.hacking.enable
            then [
                metasploit
                exploitdb
                ghidra
                wireshark
                nmap
                hashcat
                dirstalk
            ] else []
        )
        ++ (
            if config.packages.mudding.enable
            then [
                mudlet
            ] else []
        )
        ++ (
            if config.packages.gaming.enable
            then [
                steam
                protonup-qt
                steamtinkerlaunch
                prismlauncher
                mudlet
                widelands
                wesnoth
                gamescope
            ] else []
        );
}
