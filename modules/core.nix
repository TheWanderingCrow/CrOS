{
   system.stateVersion = "24.05";
   time.timeZone = "America/New_York";
   
   environment.systemPackages = with pkgs; [
      neovim
      wget
      git
      screen
      curl
      firefox
   ];

   users.users.crow = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networking" ];
   };
}
