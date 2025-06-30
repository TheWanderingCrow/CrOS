{pkgs, ...}:
pkgs.mkShell {
  name = "default";

  buildInputs = with pkgs; [
    git
    vim
    nixos-anywhere
    ssh-to-age
  ];

  shellHook = ''
    git pull
  '';
}
