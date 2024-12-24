{pkgs}: {
  config = {
    system.stateVersion = "24.05";
    time.timeZone = "America/New_York";
    nix.settings.experimental-features = ["flakes" "nix-command"];
    nix.settings.trusted-users = ["@wheel"];

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.noto
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];
  };
}
