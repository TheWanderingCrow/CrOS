{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  hostSpec = config.hostSpec;
  pubKeys = lib.filesystem.listFilesRecursive ./keys;
in
  {
    users.users.${hostSpec.username} = {
      name = hostSpec.username;
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);

      # Create ssh sockets directory for controlpaths when homemanager not loaded (i.e. isMinimal)
      systemd.tmpfiles.rules = let
        user = config.users.users.${hostSpec.username}.name;
        group = config.users.users.${hostSpec.username}.group;
      in [
        "d /home/${hostSpec.username}/.ssh 0750 ${user} ${group} -"
        "d /home/${hostSpec.username}/.ssh/sockets 0750 ${user} ${group} -"
      ];

      programs.zsh.enable = true;
      environment.systemPackages = [
        pkgs.git
        pkgs.vim
      ];
    };
  }
  // lib.optionalAttrs (inputs ? "home-manager") {
    home-manager = {
      extraSpecialArgs = {
        inherit pkgs inputs;
        hostSpec = config.hostSpec;
      };
      users.${hostSpec.username}.imports = lib.flatten (
        lib.optional (!hostSpec.isMinimal) [
          (
            {config, ...}:
              import (lib.custom.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
                inherit
                  pkgs
                  inputs
                  config
                  lib
                  hostSpec
                  ;
              }
          )
        ]
      );
    };
  }
