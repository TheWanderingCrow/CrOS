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
      vr.enable = lib.mkEnableOption "enables VR utilities";
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
    
    security.sudo.wheelNeedsPassword = false;

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
      nerdfonts.noto
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
      vr.enable = lib.mkDefault false;
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

    programs.zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        async = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)$character";

        directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
        };
        git_branch = {
          symbol = "";
          style = "bg:#394260";
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        };
        git_status = {
          style = "bg:#394260";
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        };
        php = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#1d2230";
          format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        };
      };
    };

    users.defaultUserShell = pkgs.zsh;

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
        ids = ["*"];
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
