{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    defaultSopsFile = inputs.nix-secrets.secrets.overseer;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  # Restic secrets
  sops.secrets."restic/url" = {};
  sops.secrets."restic/key" = {};
}
