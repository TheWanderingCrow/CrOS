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
      actionban = curl -H "Title: <ip> has been banned" -d "<name> jail has banned <ip> from accessing ${config.hostSpec.hostName} after <failures> attempts of hacking the system." https://notify.wanderingcrow.net/Fail2banNotifications
    '');
    # Defines a filter that detects URL probing by reading the Nginx access log
    "fail2ban/filter.d/nginx-url-probe.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      failregex = ^<HOST>.*(GET /(admin|boaform|phpmyadmin|\.env|\.git)|\.(dll|so|cfm|asp)|(\?|&)(=PHPB8B5F2A0-3C92-11d3-A3A9-4C7B08C10000|=PHPE9568F36-D428-11d2-A769-00AA001ACF42|=PHPE9568F35-D428-11d2-A769-00AA001ACF42|=PHPE9568F34-D428-11d2-A769-00AA001ACF42)|\\x[0-9a-zA-Z]{2})
    '');
  };
  services.fail2ban = {
    enable = true;
    extraPackages = [
      pkgs.curl
    ];
    ignoreIP = [
      inputs.nix-secrets.network.primary.publicIP
      "64.189.142.0/23"
    ];
    jails = {
      nginx-url-probe.settings = {
        enabled = true;
        filter = "nginx-url-probe";
        logpath = "/var/log/nginx/access.log";
        action = ''          %(action_)s[blocktype=DROP]
                           ntfy'';
        backend = "auto"; # Do not forget to specify this if your jail uses a log file
        maxretry = 5;
        findtime = 600;
      };
    };
  };
}
