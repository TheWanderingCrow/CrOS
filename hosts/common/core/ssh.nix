{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # Setup access to protected repos via our host ssh key
  environment.etc."ssh/root_config".text = ''
    Host github.com
      User git
      PreferredAuthentications publickey
      IdentityFile /etc/ssh/ssh_host_ed25519_key
  '';

  system.activationScripts.rootSSHConfig.text = ''
    install -m 0600 -o root -g root /etc/ssh/root_config /root/.ssh/config
  '';

  programs.ssh = {
    startAgent = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.fail2ban.enable = lib.mkDefault true; # This comes with an SSH jail preconfigured, expanded fail2ban can be found in modules/services
}
