{
   config,
   lib,
   pkgs,
   ...
}: {
   system.stateVersion = "24.05";
   time.timeZone = "America/New_York";
   
   environment.systemPackages = with pkgs; [
      neovim
      wget
      git
      screen
      curl
      firefox
      fish
   ];

   users.users.crow = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networking" ];
   };

   programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
   };
}
