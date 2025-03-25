{
  inputs,
  config,
  pkgs,
  ...
}: {
  config = {
    system.stateVersion = "24.05";
    time.timeZone = "America/New_York";
    nix.settings = {
      experimental-features = ["flakes" "nix-command"];
      trusted-users = ["@wheel"];
      #substituters = [" https://cache.wanderingcrow.net/wce-cache"];
      #trusted-public-keys = ["wce-cache:s5otDeH048aZEGwQ2EQn6UfFJn6YgP71bcOok1jX1Q0="];
    };

    users.mutableUsers = false;
    users.users.root.hashedPassword = "$y$j9T$pEz.3JBh6Ft3FIYrp14Ti1$RQsOWum40HbwEb7t69LGjUCh6E9w/ANi7lNIopGsu0A";

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

    nixpkgs = {
      config = {
        allowUnfree = true;
        permittedInsecurePackages =
          [
            "SDL_ttf-2.0.11"
          ]
          ++ (
            if config.module.gaming.enable
            then [
              "dotnet-runtime-wrapped-7.0.20"
              "dotnet-runtime-7.0.20"
            ]
            else []
          );
      };
      overlays = [
      ];
    };
  };
}
