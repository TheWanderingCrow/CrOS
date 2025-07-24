{
  config,
  lib,
  inputs,
  ...
}: let
  s = inputs.nix-secrets.network.mesh;
in {
  warnings =
    if !builtins.hasAttr "${config.hostSpec.hostName}" s.hosts
    then [''Hey you don't have a nebula config for this host, you should fix this ASAP so you can be connected to the mesh. If you don't know how to do this then contact your admin'']
    else [];

  services.nebula.networks.wce = lib.mkIf builtins.hasAttr "${config.hostSpec.hostName}" s.hosts {
    inherit (s) ca;
    inherit (s.hosts.${config.hostSpec.hostName}) key cert isLighthouse;
    enable = true;
  };
}
