{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs;
    (
      # Core packages
      if config.module.core.enable
      then [
        vim
        wget
        screen
        git
        curl
        tmux
        pulseaudio
        keyd
        unar
        alejandra
        nixos-generators
        restic
      ]
      else []
    )
    ++ (
      if config.module.gui.enable
      then [
        # Writing
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
        discord
        signal-desktop
        teamspeak_client

        # Browsing
        tor-browser

        # Music
        spotify
        strawberry-qt6

        # Utilities
        taskwarrior3
        neofetch
        gimp
        pulseaudio-ctl
        playerctl
        brightnessctl
      ]
      else []
    )
    ++ (
      if config.module.programming.enable
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
        godot_4
        cargo
        rustc
      ]
      else []
    )
    ++ (
      if config.module.hacking.enable
      then [
        metasploit
        exploitdb
        ghidra
        wireshark
        termshark
        nmap
        hashcat
        dirstalk
        rtl-sdr
      ]
      else []
    )
    ++ (
      if config.module.mudding.enable
      then [
        mudlet
      ]
      else []
    )
    ++ (
      if config.module.appdevel.enable
      then [
        flutter
        waydroid
        ungoogled-chromium
      ]
      else []
    )
    ++ (
      if config.module.gaming.enable
      then [
        steam
        protonup-qt
        steamtinkerlaunch
        prismlauncher
        mudlet
        widelands
        wesnoth
        cataclysm-dda
        gamescope
        gamemode
        r2modman
      ]
      else []
    )
    ++ (
      if config.module.vr.enable
      then [
        alvr
        wlx-overlay-s
        immersed
      ]
      else []
    )
    ++ (
      if config.module.art.enable
      then [
        krita
        pureref
      ]
      else []
    );
}
