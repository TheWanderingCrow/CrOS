{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
in {
  sops = {
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostName}.yaml";
    validateSopsFiles = false;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
