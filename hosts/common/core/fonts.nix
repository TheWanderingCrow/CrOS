{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf (!config.hostSpec.isMinimal) {
  fonts = {
    packages = with pkgs; [
      # Emoji and general symbols
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      unifont

      # Nerd fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.fira-code
      nerd-fonts.noto
      nerd-fonts.ubuntu-mono
      nerd-fonts.dejavu-sans-mono

      # Icon fonts
      font-awesome
      material-design-icons
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Hack Nerd Font"
          "FiraCode Nerd Font"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
          "DejaVu Serif"
        ];
        emoji = [
          "Noto Color Emoji"
          "Symbola"
        ];
      };
    };
  };
}
