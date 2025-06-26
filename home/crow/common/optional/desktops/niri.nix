{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
  ];
  nixpkgs.overlays = [
    inputs.niri-flake.overlays.niri
  ];

  programs.niri = {
    enable = true;
    settings = {
      binds = with config.lib.niri.actions; {
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
      };
      input = {
        keyboard = {
          numlock = true;
        };
        touchpad = {
          tap = false;
          natural-scroll = true;
          click-method = "button-areas";
          disabled-on-external-mouse = true;
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
