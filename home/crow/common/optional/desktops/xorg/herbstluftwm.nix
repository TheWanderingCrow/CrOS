{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # To set wallpaper
    hsetroot
    # For xinput
    perl
    gnugrep
    xorg.xinput
  ];

  xsession.windowManager.herbstluftwm = let
    mod = "Mod4";
  in {
    enable = true;

    tags = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];

    keybinds = lib.mkMerge [
      {
        "${mod}-q" = "close";
        "${mod}-r" = "remove";
        "${mod}-Return" = "spawn wezterm";
        "${mod}-b" = "spawn ${config.programs.firefox.finalPackage}/bin/firefox";
        "${mod}-d" = "spawn rofi -show drun";
        "${mod}-Shift-s" = let
          screenshot = pkgs.writeShellScriptBin "screenshot" ''
            sleep 0.2
            exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
          '';
        in "spawn ${screenshot}/bin/screenshot";
        "${mod}-Shift-Ctrl-l" = let
          lock = pkgs.writeShellScriptBin "lock" ''
            exec ${pkgs.xsecurelock}/bin/xsecurelock
          '';
        in "spawn ${lock}/bin/lock";
        # Shift-Ctrl-odiaeresis = Shift+Ctrl+ö
        "${mod}-Shift-Ctrl-odiaeresis" = "spawn ${pkgs.xsecurelock}/bin/xsecurelock";
        "XF86Display" = "spawn autorandr -c";
        "${mod}-Shift-d" = "spawn autorandr -c";
        "${mod}-l" = "focus right";
        "${mod}-k" = "focus up";
        "${mod}-j" = "focus down";
        "${mod}-h" = "focus left";
        "${mod}-Shift-l" = "shift right";
        "${mod}-Shift-k" = "shift up";
        "${mod}-Shift-j" = "shift down";
        "${mod}-Shift-h" = "shift left";
        "${mod}-u" = "split bottom 0.5";
        "${mod}-o" = "split right 0.5";
        "${mod}-Ctrl-space" = "split explode";
        "${mod}-f" = "fullscreen toggle";
        "${mod}-s" = "floating toggle";
        "${mod}-p" = "pseudotile toggle";
        "${mod}-space" = "or , and . compare tags.focus.curframe_wcount = 2 . cycle_layout +1 vertical horizontal max vertical grid , cycle_layout +1";
      }
      (lib.mkMerge (lib.lists.imap0
        # this won't work if tags has more than 9 elements
        (i: _: let
          index = builtins.toString i;
          key = builtins.toString (i + 1);
        in {
          "${mod}-${key}" = "use_index ${index}";
          "${mod}-Shift-${key}" = "move_index ${index}";
        })
        config.xsession.windowManager.herbstluftwm.tags))
    ];

    mousebinds = {
      "${mod}-Button1" = "move";
      "${mod}-Button2" = "zoom";
      "${mod}-Button3" = "resize";
    };

    rules = [
      "focus=on" # focus new windows by default
      "windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on"
      "windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on"
      "windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off"
      "class=Spotify focus=off tag=4"
      "class=Slack focus=off tag=2"
      "class=zoom focus=off tag=2"
      "class=firefox tag=1"
    ];

    settings = {
      frame_border_active_color = "#ed8796";
      frame_border_normal_color = "#181926";
    };

    extraConfig = ''
      autorandr -c

      xsetroot -cursor_name left_ptr &
      polybar &
      ${config.programs.firefox.finalPackage}/bin/firefox &
      ${lib.optionalString config.modules.social.slack.enable "slack &"}
      ${lib.optionalString config.modules.nifty.media.spotify.enable "spotify &"}
      ${lib.optionalString ((builtins.length osConfig.modules.mouse.settings) > 0) "marimouse &"}
    '';
  };
}
