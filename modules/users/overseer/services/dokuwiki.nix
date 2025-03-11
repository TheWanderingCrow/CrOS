{pkgs, ...}: {
  services.dokuwiki.sites = {
    "wiki.wanderingcrow.net" = {
      enable = true;
      templates = let
        template-bootstrap3 = pkgs.stdenv.mkDerivation rec {
          name = "bootstrap3";
          version = "2022-07-27";
          src = pkgs.fetchFromGitHub {
            owner = "giterlizzi";
            repo = "dokuwiki-template-bootstrap3";
            rev = "v2024-02-06";
            hash = "sha256-PSA/rHMkM/kMvOV7CP1byL8Ym4Qu7a4Rz+/aPX31x9k=";
          };
          installPhase = "mkdir -p $out; cp -R * $out/";
        };
      in [template-bootstrap3];
      settings = {
        superuser = "admin";
        useacl = true;
        template = "bootstrap3";
      };
      usersFile = let
        thingy = pkgs.writeText "temp.txt" ''
          admin:$2y$04$eYnNuWVWUQXzumP65aOcq.UraMpF2b9olqz555nsbdRhUJjreuit6:admin:admin@example.com:admin
        '';
      in
        toString thingy;
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "wiki.wanderingcrow.net" = {
        forceSSL = true;
        useACMEHost = "wiki.wanderingcrow.net";
      };
    };
  };
}
