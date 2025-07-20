{pkgs, ...}:
pkgs.mkShell {
  name = "droid";

  buildInputs = with pkgs; [
    git
    ssh
  ];
}