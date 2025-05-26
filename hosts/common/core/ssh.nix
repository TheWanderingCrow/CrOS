{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ssh = {
    startAgent = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
