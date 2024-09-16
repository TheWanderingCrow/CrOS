{
   config,
   lib,
   pkgs,
   ...
}: {
   system.stateVersion = "24.05";
   time.timeZone = "America/New_York";
   
   users.users.crow = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networking" ];
   };
}
