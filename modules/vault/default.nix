{ inputs, pkgs, lib, config, ...}: {
    
    options.vault.enable = lib.mkEnableOption "enables hashicorp vault services";

    config = {
        services.vault = lib.mkIf config.vault.enable {
            enable = true;
            address = "localhost:8200";
        };
    };
}
