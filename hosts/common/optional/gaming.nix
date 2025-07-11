{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      protontricks = {
        enable = true;
      };
      extraCompatPackages = [pkgs.unstable.proton-ge-bin];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    #FIXME(TODO): Figure out what the best settings are, maybe override these in specific host configs?
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    vintagestory
    mudlet
    r2modman
    prismlauncher
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20" # VintageStory dep
  ];
}
