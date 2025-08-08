{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    pulseaudio
    playerctl
    brightnessctl
    wezterm
    xorg.xinit
    xorg.xauth
    slock
    rofi
  ];

  xsession = {
    enable = true;
    windowManager.spectrwm = {
      enable = true;
      programs = {
        term = "wezterm";
        lock = "slock";
        menu = "rofi -show run";
        search = "rofi -show window";
      };
      bindings = {
        menu = "MOD+d";
        quit = "MOD+Shift+e";
        term = "MOD+Return";
        wind_del = "MOD+q";
        wind_kill = "MOD+Shift+q";
      };
      unbindings = [
        "MOD+Shift+q"
      ];
      settings = {
        modkey = "Mod4";
        workspace_limit = 10;
        focus_mode = "default";
        tile_gap = 3;
        region_padding = 3;
        border_width = 2;
        color_focus = "rgb:ff/b6/99";
        color_unfocus = "rgb:75/73/73";
        workspace_clamp = 1;
        warp_focus = 0;
        warp_pointer = 0;
        focus_close_wrap = 1;
      };
    };
  };
}
