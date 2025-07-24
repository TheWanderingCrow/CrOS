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
}
