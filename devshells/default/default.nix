{pkgs, ...}:
pkgs.mkShell {
  name = "default";

  buildInputs = builtins.attrValues {
    inherit
      (pkgs)
      git
      vim
      nixos-anywhere
      ssh-to-age
      ;
  };

  shellHook = ''
    git pull
  '';
}
