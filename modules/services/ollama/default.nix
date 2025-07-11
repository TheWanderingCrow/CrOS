{
  config,
  pkgs,
  ...
}: {
  services.ollama = {
    enable = true;
    loadModels = [];
    acceleration = "rocm";
  };

  services.open-webui = {
    enable = true;
    port = 3000;
    host = "0.0.0.0";
    openFirewall = true;
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server.limiter = false;
      server.secret_key = "temptestsecret";
      server.port = 3001;
      server.bind_address = "0.0.0.0";
      search.formats = [
        "html"
        "json"
      ];
    };
    limiterSettings = {
      botdetection = {
        ip_limit.link_token = false;
        ip_lists.block_ip = [];
        ip_lists.pass_ip = [];
      };
    };
  };
}
