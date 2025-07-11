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
  ];

  home.packages = with pkgs; [
    screen
  ];

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
}
