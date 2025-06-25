{pkgs, ...}:
pkgs.mkShell {
  name = "default";

  buildInputs = with pkgs; [
    git
    vim
  ];

  shellHook = ''
    git pull
  '';
}
