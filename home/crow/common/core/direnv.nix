{
  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
