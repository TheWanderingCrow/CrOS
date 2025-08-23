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
    # Defines a filter that detects URL probing by reading the Nginx access log
    "fail2ban/filter.d/nginx-ddos-protect.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      failregex = ^<HOST> - - \[.*\] "GET .* HTTP/.*" \d{3} \d+ "-" "ApacheBench/.+"
                  limiting requests, excess:.* by zone.*client: <HOST>
                  ^.*\[error\]\s+\d+#\d+:\s+\*\d+\s+connect\(\) to unix:.*failed.*while connecting to upstream,\s+client:\s+<HOST>,\s+server:.*
                  ^.*\[error\]\s+\d+#\d+:\s+\*\d+\s+upstream prematurely closed connection while reading response header from upstream,\s+client:\s+<HOST>,.*$
      ignoreregex =
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
    jails = {
      nginx-ddos-protect.settings = {
        enabled = true;
        filter = "nginx-ddos-protect";
        logpath = "/var/log/nginx/*.log";
        action = ''          %(action_)s[blocktype=DROP]
                           ntfy'';
        backend = "auto"; # Do not forget to specify this if your jail uses a log file
        maxretry = 1;
        findtime = 3600;
      };
    };
  };
}
