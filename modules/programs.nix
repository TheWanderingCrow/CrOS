{ inputs, pkgs, lib, config, ...}: {
    environment.systemPackages = with pkgs;
        (
            # Core packages
            if config.packages.core.enable
            then [
                vim
                wget
                git
                screen
                curl
                foot
                tmux
                pulseaudio
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
                firefox
                tor-browser

                # Music
                spotify
                strawberry-qt6

                # Utilities
                grim
                hyfetch
                gimp
            ] else []
        )
        ++ (
            if config.packages.programming.enable
            then [
                neovim
                lua
                libgcc
                php
                python3
                serverless
                jwt-cli
                jq
                ddev
                cloc
                ansible
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
                prismlauncher
                mudlet
                widelands
                wesnoth
            ] else []
        );
}
