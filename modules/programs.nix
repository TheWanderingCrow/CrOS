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
                hyfetch
                gimp
		foot
            ] else []
        )
        ++ (
            if config.packages.programming.enable
            then [
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
                prismlauncher
                mudlet
                widelands
                wesnoth
            ] else []
        );
}
