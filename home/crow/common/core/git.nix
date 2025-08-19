{
  programs.git = {
    enable = true;
    userName = "TheWanderingCrow";
    userEmail = "contact@wanderingcrow.net";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
    lfs = {
      enable = true;
      skipSmudge = true;
    };
  };
}
