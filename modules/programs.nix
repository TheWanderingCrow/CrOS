{
   environment.systemPackages = with pkgs; [
      neovim
      wget
      git
      screen
      curl
      firefox
      fish
   ];
   
   programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
   };
}
