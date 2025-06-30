{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];
}
