{ config, ... }: {
    imports = 
    (
        if config.users.crow.enable then
        [./crow.nix]
	else []
    );
    # ++ ( to add more, just move the ;
    
}
