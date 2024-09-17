{pkgs, ...}: let
    username = "crow";
    homeDirectory = "/home/${username}";
    configHome = "${homeDirectory}/.config";
in {
    home = {
        inherit username homeDirectory;
        stateVersion = system.stateVersion;
    };

    xdg = {
        inherit configHome;
        enable = true;
    }

    programs = {};
}
