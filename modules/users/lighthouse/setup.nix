{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.lighthouse.enable {
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  sops.secrets.cert = {};
  sops.secrets.key = {};

  services.nebula.networks.WCE = {
    enable = true;
    isLighthouse = true;
    ca = inputs.nix-secrets.nebula.ca;
    cert = config.sops.secrets.cert.path;
    key = config.sops.secrets.key.path;
    settings = {
      listen = {
        host = "0.0.0.0";
        port = 4242;
      };
    };
  };
}
