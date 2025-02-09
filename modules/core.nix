{pkgs, ...}: {
  config = {
    system.stateVersion = "24.05";
    time.timeZone = "America/New_York";
    nix.settings = {
      experimental-features = ["flakes" "nix-command"];
      trusted-users = ["@wheel"];
      substituters = [" https://cache.wanderingcrow.net/wce-cache"];
      trusted-public-keys = ["wce-cache:s5otDeH048aZEGwQ2EQn6UfFJn6YgP71bcOok1jX1Q0="];
    };

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
