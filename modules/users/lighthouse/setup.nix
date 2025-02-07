{
  lib,
  inputs,
  config,
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
    inherit (inputs.nix-secrets.nebula) ca;
    enable = true;
    isLighthouse = true;
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
