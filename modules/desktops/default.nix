{ lib, config, ...}: {
    imports = [
        # Wayland desktops here
        ./wayland/sway.nix
        
        # X11 desktops here
        ./x11/i3.nix
    ];
}

