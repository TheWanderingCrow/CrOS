{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
    ./sway/waybar.nix
  ];
  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
  ];

  home.packages = with pkgs; [
    foot
    wofi
    swaynotificationcenter
    polkit_gnome
    swayidle
    sway-audio-idle-inhibit
    swaylock-effects
    sway-contrib.grimshot
    waybar
    wl-clipboard
    hyprlock
    grim
    slurp
    swappy
    wljoywake
  ];

  programs.niri = {
    enable = true;
    settings = {
      binds = with config.lib.niri.actions; {
        # Shortcuts
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Return" = {
          hotkey-overlay.title = "Open terminal";
          action = spawn "foot";
        };
        "Mod+D" = {
          hotkey-overlay.title = "Open Application Picker";
          action = spawn "wofi" "--show" "run";
        };
        "Mod+Shift+Z" = {
          hotkey-overlay.title = "Lock computer";
          action = spawn "";
        };
        "Mod+Shift+E" = {
          action = quit;
        };
        "Mod+O" = {
          action = toggle-overview;
        };
        # Audio Control
        XF86AudioRaiseVolume = {
          action = spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%";
          allow-when-locked = true;
        };
        XF86AudioLowerVolume = {
          action = spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%";
          allow-when-locked = true;
        };
        XF86AudioMute = {
          action = spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle";
          allow-when-locked = true;
        };
        XF86AudioMicMute = {
          action = spawn "pulseaudio-ctl" "mute-input";
          allow-when-locked = true;
        };
        XF86AudioPlay = {
          action = spawn "playerctl" "play-pause";
          allow-when-locked = true;
        };
        XF86AudioNext = {
          action = spawn "playerctl" "next";
          allow-when-locked = true;
        };
        XF86AudioPrev = {
          action = spawn "playerctl" "previous";
          allow-when-locked = true;
        };
        # Brightness Control
        XF86MonBrightnessUp = {
          action = spawn "brightnessctl" "s" "+5%";
          allow-when-locked = true;
        };
        XF86MonBrightnessDown = {
          action = spawn "brightnessctl" "s" "-5%";
          allow-when-locked = true;
        };
        # Application Controls
        "Mod+Shift+Q" = {
          action = close-window;
        };
        "Mod+Left" = {action = focus-column-left;};
        "Mod+Down" = {action = focus-window-down;};
        "Mod+Up" = {action = focus-window-up;};
        "Mod+Right" = {action = focus-column-right;};
        "Mod+H" = {action = focus-column-left;};
        "Mod+J" = {action = focus-window-down;};
        "Mod+K" = {action = focus-window-up;};
        "Mod+L" = {action = focus-column-right;};

        "Mod+Ctrl+Left" = {action = move-column-left;};
        "Mod+Ctrl+Down" = {action = move-window-down;};
        "Mod+Ctrl+Up" = {action = move-window-up;};
        "Mod+Ctrl+Right" = {action = move-column-right;};
        "Mod+Ctrl+H" = {action = move-column-left;};
        "Mod+Ctrl+J" = {action = move-window-down;};
        "Mod+Ctrl+K" = {action = move-window-up;};
        "Mod+Ctrl+L" = {action = move-column-right;};
        "Mod+Home" = {action = focus-column-first;};
        "Mod+End" = {action = focus-column-last;};
        "Mod+Ctrl+Home" = {action = move-column-to-first;};
        "Mod+Ctrl+End" = {action = move-column-to-last;};

        "Mod+Shift+Left" = {action = focus-monitor-left;};
        "Mod+Shift+Down" = {action = focus-monitor-down;};
        "Mod+Shift+Up" = {action = focus-monitor-up;};
        "Mod+Shift+Right" = {action = focus-monitor-right;};
        "Mod+Shift+H" = {action = focus-monitor-left;};
        "Mod+Shift+J" = {action = focus-monitor-down;};
        "Mod+Shift+K" = {action = focus-monitor-up;};
        "Mod+Shift+L" = {action = focus-monitor-right;};

        "Mod+Shift+Ctrl+Left" = {action = move-column-to-monitor-left;};
        "Mod+Shift+Ctrl+Down" = {action = move-column-to-monitor-down;};
        "Mod+Shift+Ctrl+Up" = {action = move-column-to-monitor-up;};
        "Mod+Shift+Ctrl+Right" = {action = move-column-to-monitor-right;};
        "Mod+Shift+Ctrl+H" = {action = move-column-to-monitor-left;};
        "Mod+Shift+Ctrl+J" = {action = move-column-to-monitor-down;};
        "Mod+Shift+Ctrl+K" = {action = move-column-to-monitor-up;};
        "Mod+Shift+Ctrl+L" = {action = move-column-to-monitor-right;};
        "Mod+Page_Down" = {action = focus-workspace-down;};
        "Mod+Page_Up" = {action = focus-workspace-up;};
        "Mod+U" = {action = focus-workspace-down;};
        "Mod+I" = {action = focus-workspace-up;};
        "Mod+Ctrl+Page_Down" = {action = move-column-to-workspace-down;};
        "Mod+Ctrl+Page_Up" = {action = move-column-to-workspace-up;};
        "Mod+Ctrl+U" = {action = move-column-to-workspace-down;};
        "Mod+Ctrl+I" = {action = move-column-to-workspace-up;};

        "Mod+Shift+Page_Down" = {action = move-workspace-down;};
        "Mod+Shift+Page_Up" = {action = move-workspace-up;};
        "Mod+Shift+U" = {action = move-workspace-down;};
        "Mod+Shift+I" = {action = move-workspace-up;};

        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight" = {action = focus-column-right;};
        "Mod+WheelScrollLeft" = {action = focus-column-left;};
        "Mod+Ctrl+WheelScrollRight" = {action = move-column-right;};
        "Mod+Ctrl+WheelScrollLeft" = {action = move-column-left;};

        "Mod+Shift+WheelScrollDown" = {action = focus-column-right;};
        "Mod+Shift+WheelScrollUp" = {action = focus-column-left;};
        "Mod+Ctrl+Shift+WheelScrollDown" = {action = move-column-right;};
        "Mod+Ctrl+Shift+WheelScrollUp" = {action = move-column-left;};

        "Mod+1" = {action = focus-workspace 1;};
        "Mod+2" = {action = focus-workspace 2;};
        "Mod+3" = {action = focus-workspace 3;};
        "Mod+4" = {action = focus-workspace 4;};
        "Mod+5" = {action = focus-workspace 5;};
        "Mod+6" = {action = focus-workspace 6;};
        "Mod+7" = {action = focus-workspace 7;};
        "Mod+8" = {action = focus-workspace 8;};
        "Mod+9" = {action = focus-workspace 9;};

        "Mod+BracketLeft" = {action = consume-or-expel-window-left;};
        "Mod+BracketRight" = {action = consume-or-expel-window-right;};

        "Mod+Comma" = {action = consume-window-into-column;};

        "Mod+Period" = {action = expel-window-from-column;};

        "Mod+R" = {action = switch-preset-column-width;};
        "Mod+Shift+R" = {action = switch-preset-window-height;};
        "Mod+Ctrl+R" = {action = reset-window-height;};
        "Mod+F" = {action = maximize-column;};
        "Mod+Shift+F" = {action = fullscreen-window;};

        "Mod+Ctrl+F" = {action = expand-column-to-available-width;};

        "Mod+C" = {action = center-column;};

        "Mod+Ctrl+C" = {action = center-visible-columns;};

        "Mod+Minus" = {action = set-column-width "-10%";};
        "Mod+Equal" = {action = set-column-width "+10%";};

        "Mod+Shift+Minus" = {action = set-window-height "-10%";};
        "Mod+Shift+Equal" = {action = set-window-height "+10%";};

        "Mod+V" = {action = toggle-window-floating;};
        "Mod+Shift+V" = {action = switch-focus-between-floating-and-tiling;};

        "Mod+W" = {action = toggle-column-tabbed-display;};

        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };
      };
      input = {
        keyboard = {
          numlock = true;
        };
        touchpad = {
          tap = false;
          natural-scroll = true;
          click-method = "button-areas";
        };
      };
      layout = {
        gaps = 16;
      };
      spawn-at-startup = [
        {command = ["waybar"];}
      ];
    };
  };
}
