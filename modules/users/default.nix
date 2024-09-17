{ config, ... }: {
    imports = [
    (
        if config.users.crow.enable then
        ./crow.nix
    );
    # ++ ( to add more, just move the ;
    ];
}
