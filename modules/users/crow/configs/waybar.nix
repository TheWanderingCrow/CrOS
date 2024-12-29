{config, ...}: let


og_waybar = {

};

in {
    programs.waybar = {
        enable = config.desktops.sway.enable or config.desktops.swayfx.enable;
    };

}
