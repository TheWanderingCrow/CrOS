{
  lib,
  config,
  ...
}:
lib.mkIf config.user.overseer.enable {
    sops.secrets."bookstack/key" = {
        owner = "bookstack";
    };
        
    services.bookstack = {
        enable = true;
        hostname = "bookstack.wanderingcrow.net";
        database.createLocally = true;
        appKeyFile = config.sops.secrets."bookstack/key".path;
    };
}
