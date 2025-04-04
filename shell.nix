{pkgs ? import <nixpkgs> {}, ...}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    DIGITALOCEAN_TOKEN = builtins.readFile /run/secrets/digitalocean/token;
    CLOUDFLARE_API_TOKEN = builtins.readFile /run/secrets/cloudflare/token;
    AWS_PROFILE = "wce";
    B2_APPLICATION_KEY_ID = builtins.readFile /run/secrets/backblaze/id;
    B2_APPLICATION_KEY = builtins.readFile /run/secrets/backblaze/key;
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
