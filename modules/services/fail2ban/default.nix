{
  inputs,
  config,
  pkgs,
  ...
}: {
  environment.etc = {
    # Define an action that will trigger a Ntfy push notification upon the issue of every new ban
    "fail2ban/action.d/ntfy.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      norestored = true # Needed to avoid receiving a new notification after every restart
      actionban = curl -H "Title: <ip> has been banned" -d "<name> jail has banned <ip> from accessing ${config.hostSpec.hostName} after <failures> attempts of attacking the system." https://notify.wanderingcrow.net/Fail2banNotifications
    '');
  };
  services.fail2ban = {
    enable = true;
    extraPackages = [
      pkgs.curl
    ];
    ignoreIP = [
      inputs.nix-secrets.network.primary.publicIP
    ];
  };
}
