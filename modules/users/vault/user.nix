{ lib, config, ...}: {
    config.users.users.vault = lib.mkIf config.users.vault.enable {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [];
    };
}
