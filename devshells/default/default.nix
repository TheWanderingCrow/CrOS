{pkgs, ...}:
pkgs.mkShell {
  name = "default";

  buildInputs = with pkgs; [
    git
    vim
    nixos-anywhere
  ];

  shellHook = ''
    git pull
  '';
}
