{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}: let
  platform =
    if hostSpec.isDarwin
    then "darwin"
    else "nixos";
in {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      "modules/home"
    ])
    #./${platform.nix}
    ./xdg.nix
    ./direnv.nix
    ./tmux.nix
    ./git.nix
    ./nushell.nix
    ./starship.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      screen
      ouch
      bitwarden-cli
      aider-chat-full
      ;
  };

  inherit hostSpec;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.05";

    sessionVariables = {
      SHELL = "zsh";
      TERM = "foot";
      TERMINAL = "foot";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };
}
