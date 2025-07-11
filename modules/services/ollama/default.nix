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

  networking.firewall.allowedTCPPorts = [3000];

  services.nextjs-ollama-llm-ui = {
    enable = true;
    port = 3000;
    hostname = "0.0.0.0";
  };
}
