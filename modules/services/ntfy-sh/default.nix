{
  services.caddy = {
    enable = true;
    virtualHosts."notify.wanderingcrow.net".extraConfig = ''
      reverse_proxy http://localhost:9089
    '';
  };
  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://notify.wanderingcrow.net";
      listen-http = ":9089";
      behind-proxy = true;
    };
  };
}
