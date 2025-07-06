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
      #"modules/home"
    ])
    #./${platform.nix}
  ];

  inherit hostSpec;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.05";

    sessionVariables = {
      SHELL = "zsh";
      TERM = "konsole";
      TERMINAL = "konsole";
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };
}
