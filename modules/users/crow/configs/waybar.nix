{osConfig, ...}: let
  # screenshots/og_waybar.jpg
  og_waybar = {
    jsonc = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        mode = "dock";
        margin = "10";
        modules-left = ["sway/workspaces"];
        modules-center = ["clock"];
        modules-right = ["network" "battery" "backlight" "pulseaudio" "tray"];
        tray = {
          spacing = 10;
        };
        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰈹";
            "2" = "";
            "3" = "";
            "4" = "󰎆";
            "5" = "󰓥";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
          sort-by-number = true;
          persistent-workspaces = {
            "1" = ["HDMI-A-1"];
            "2" = ["HDMI-A-1"];
            "3" = ["DP-1"];
          };
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%m-%d-%Y}";
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
          interval = 30;
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["󰃞" "󰃟" "󰃠"];
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
      };
    };
    style = ''
      @define-color fg #AAB775;
      @define-color bg #060617;
      @define-color disabled #a5a5a5;
      @define-color alert #f53c3c;
      @define-color activegreen #8fb666;

      * {
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font", "Hack Nerd Font", "Font Awesome 6 Free Regular", "Font Awesome 6 Free Solid", "Font Awesome 6 Brands";
        font-size: 14px;
      }

      window#waybar {
        color: @fg;
        background: @bg;
        transition-property: background-color;
        border-radius: 25px;
        transition-duration: 0.5s;

      }

      window#waybar.empty {
        opacity: 0.3;
      }

      button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
        border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px transparent;
      }

      #workspaces button {
        color: @fg;
        /* padding : 0px 5px; */
      }

      #workspaces button.urgent {
        color: @alert;
      }
      #workspaces button.empty {
        color: @disabled;
      }

      #workspaces button.active {
          border-bottom: 2px solid #DCAA9B;
          border-radius: 0;
          margin-top: 2px;
          color: #DCAA9B;
          transition: none;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #language,
      #backlight,
      #backlight-slider,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #taskbar,
      #tray,
      #tray menu,
      #tray > .needs-attention,
      #tray > .passive,
      #tray > .active,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #custom-power,
      #window,
      #mpd {
        padding: 0px 5px;
        padding-right: 10px;
        margin: 3px 3px;
        color: @fg;
      }

      #custom-power {
        color: @fg;
        padding-left: 10px;
      }

      #custom-separator {
        color: @disabled;
      }

      #network.disconnected,
      #pulseaudio.muted,
      #wireplumber.muted {
        color: @alert;
      }

      #battery.charging,
      #battery.plugged {
        color: #26a65b;
      }

      label:focus {
        background-color: #333333;
      }

      #battery.critical:not(.charging) {
        background-color: @alert;
        color: @fg;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

    '';
  };
in {
  programs.waybar = {
    enable = true;
    settings =
      if osConfig.ricing.basic.enable
      then og_waybar.jsonc
      else {};
    style =
      if osConfig.ricing.basic.enable
      then og_waybar.style
      else "";
  };
}
