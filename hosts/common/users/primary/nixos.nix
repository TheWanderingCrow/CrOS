# User config applicable only to nixos
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  hostSpec = config.hostSpec;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  # Decrypt password to /run/secrets-for-users/ so it can be used to create the user
  sopsHashedPasswordFile = lib.optionalString (!config.hostSpec.isMinimal) config.sops.secrets."passwords/${hostSpec.username}".path;
in {
  users = {
    mutableUsers = false; # Only allow declarative credentials; Required for password to be set via sops during system activation!
    users = {
      # Default user for the host set in hostspec
      ${hostSpec.username} = {
        home = "/home/${hostSpec.username}";
        isNormalUser = true;
        hashedPasswordFile = sopsHashedPasswordFile; # Blank if sops is not working.
        linger = true;

        extraGroups = lib.flatten [
          "wheel"
          (ifTheyExist [
            "audio"
            "video"
            "docker"
            "podman"
            "dialout"
            "git"
            "networkmanager"
            "scanner" # for print/scan"
            "lp" # for print/scan"
          ])
        ];
      };

      # Root user setup
      root = {
        shell = pkgs.zsh;
        hashedPasswordFile = config.users.users.${hostSpec.username}.hashedPasswordFile;
        openssh.authorizedKeys.keys = config.users.users.${hostSpec.username}.openssh.authorizedKeys.keys; # root's ssh keys are mainly used for remote deployment.
      };
    };
  };
  # No matter what environment we are in we want these tools for root, and the user(s)
  programs.git.enable = true;
}
