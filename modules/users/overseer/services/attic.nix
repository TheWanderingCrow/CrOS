{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    secrets."attic/server_token" = {};
    secrets."cloudflare/r2/access_key" = {};
    secrets."cloudflare/r2/secret_key" = {};
    templates."attic-env".content = ''
      ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64=${config.sops.placeholder."attic/server_token"}
      AWS_ACCESS_KEY_ID=${config.sops.placeholder."cloudflare/r2/access_key"}
      AWS_SECRET_ACCESS_KEY=${config.sops.placeholder."cloudflare/r2/secret_key"}
    '';
  };
  services = {
    atticd = {
      enable = true;
      mode = "monolithic";
      environmentFile = config.sops.templates."attic-env".path;
      settings = {
        listen = "[::]:8080";
        api-endpoint = "https://cache.wanderingcrow.net/";
        jwt = {};
        chunking = {
          nar-size-threshold = 64 * 1024; # 64 KiB
          min-size = 16 * 1024; # 16 KiB
          avg-size = 64 * 1024; # 64 KiB
          max-size = 256 * 1024; # 256 KiB
        };
        storage = {
          type = "s3";
          region = "";
          bucket = "wce-attic-cache";
          endpoint = "https://68c4b3ab47c1a97037ab5a938f772d69.r2.cloudflarestorage.com";
        };
      };
    };
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "cache.wanderingcrow.net" = {
          forceSSL = true;
          useACMEHost = "cache.wanderingcrow.net";
          locations."/" = {
            proxyPass = "http://localhost:8080";
            proxyWebsockets = true;
          };
        };
      };
    };
  };
}
