{ config, ... }: {
    imports = 
    (
        if config.users.crow.home.enable then
        [./crow/home.nix] else []
    );
    # ++ ( to add more, just move the ;
}
