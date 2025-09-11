{
  inputs,
  config,
  pkgs,
  ...
}: let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
in {
  users.users.caddy.extraGroups = ["netbox"];

  sops.secrets."netbox/secret-key" = {
    owner = "netbox";
    sopsFile = "${sopsFolder}/shared.yaml";
  };

  services.caddy = {
    enable = true;
    virtualHosts."netbox.wanderingcrow.net".extraConfig = ''
      file_server /static/
      reverse_proxy http://${config.services.netbox.listenAddress}:${builtins.toString config.services.netbox.port}
    '';
  };

  services.netbox = {
    enable = true;
    package = pkgs.netbox;
    listenAddress = "0.0.0.0";
    port = 9099;
    secretKeyFile = config.sops.secrets."netbox/secret-key".path;
    plugins = ps: with ps; [ps.netbox-topology-views];
    settings.PLUGINS = ["netbox_topology_views"];
  };
}
