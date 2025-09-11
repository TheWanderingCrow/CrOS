{
  lib,
  config,
  inputs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."wanderingcrow.net".extraConfig = ''
      root ${inputs.the-nest.outputs.packages.x86_64-linux.default}
      file_server
    '';
  };
}
