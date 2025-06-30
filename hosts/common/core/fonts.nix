{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      nerd-fonts.noto
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font" "Hack Nerd Font"];
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
