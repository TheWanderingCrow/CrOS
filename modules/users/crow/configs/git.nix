{
  programs.git = {
    enable = true;
    userName = "TheWanderingCrow";
    userEmail = "contact@wanderingcrow.net";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  lfs = {
    enable = true;
    skipSmudge = true;
  };
}
