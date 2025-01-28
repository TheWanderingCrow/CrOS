{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
lib.mkIf config.user.lighthouse.enable {


    services.nebula.networks.test = {
        enable = true;
        isLighthouse = true;
    };
        
}
