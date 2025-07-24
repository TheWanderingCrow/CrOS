{
  config,
  lib,
  inputs,
  hostSpec,
  ...
}: let
  s = inputs.nix-secrets.network.mesh;
in
  if builtins.hasAttr "${hostSpec.hostName}" s.hosts
  then lib.warn "Hey you don't have a nebula host config for this host, we'll still build but you should fix this ASAP since you won't be inside the mesh. If you don't know how to do this please talk to your computer administrator (me haha)"
  else {
    services.nebula.networks.wce = {
      inherit (s) ca;
      inherit (s.hostSpec.hostName) cert key;
      enable = true;
      isLighthouse = lib.mkDefault false;
    };
  }
