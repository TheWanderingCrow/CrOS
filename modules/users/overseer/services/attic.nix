{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
  sops = {
    secrets."attic/server_token" = {};
    secrets."aws/access_key" = {};
    secrets."aws/secret_key" = {};
    templates."attic-env".content = ''
      ATTIC_SERVER_TOKEN_RS256_SECRET_BASE64=${config.sops.placeholder."attic/server_token"}
      AWS_ACCESS_KEY_ID=${config.sops.placeholder."aws/access_key"}
      AWS_SECRET_ACCESS_KEY=${config.sops.placeholder."aws/secret_key"}
    '';
  };
  services.atticd = {
    enable = true;
    mode = "monolithic";
    environmentFile = config.sops.templates."attic-env".path;
    settings = {
      listen = "[::]:8080";
      jwt = {};
      chunking = {
        nar-size-threshold = 64 * 1024; # 64 KiB
        min-size = 16 * 1024; # 16 KiB
        avg-size = 64 * 1024; # 64 KiB
        max-size = 256 * 1024; # 256 KiB
      };
      storage = {
        type = "s3";
        region = "us-east-1";
        bucket = "wce-20250209044958802100000001";
      };
    };
  };
}
