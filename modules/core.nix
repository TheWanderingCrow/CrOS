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
        (final: prev: {frigate = inputs.unstable-small.legacyPackages.${prev.system}.frigate;})
      ];
    };
  };
}
