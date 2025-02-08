{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      vim
      terraform
      doctl
      awscli2
    ];
    shellHook = ''
      nix build .#terranix.wce -o config.tf.json
      zsh
    '';
  };
}
