{ config, ... }: {
    imports = [
    (
        if config.users.crow.home.enable then
        ./crow.nix
    );
    # ++ ( to add more, just move the ;
    ];
}
